import errorHandler from "../middleware/error.middleware.js";
import Cart from "../models/Cart.model.js";
import CartItem from "../models/CartItem.model.js";
import Notification from "../models/Notification.model.js";
import Log from "../models/Log.model.js";
import Order from "../models/Order.model.js";

export const createOrder = async (req, res, next) => {
  const userId = req.user._id;
  if (!userId) {
    return next(errorHandler(401, "Unauthorized"));
  }
  try {
    const cart = await Cart.findOne({ userId });
    if (!cart) {
      return next(errorHandler(404, "Cart not found against this user"));
    }
    const cartItems = await CartItem.find({ cartId: cart._id })
      .select("-cartId")
      .populate("productId");
    const orderItems = cartItems.map((item) => {
      const { productId, quantity } = item;

      const selectedVariants = productId.variantGroups
        .filter((vg) =>
          item.selectedOptions.some(
            (sel) => sel.variantGroupId.toString() === vg._id.toString()
          )
        )
        .map((vg) => {
          const groupSelection = item.selectedOptions.find(
            (sel) => sel.variantGroupId.toString() === vg._id.toString()
          );

          if (!groupSelection) {
            return {
              groupId: vg._id,
              groupName: vg.name,
              options: [],
            };
          }

          const chosenOptions = vg.options.filter((opt) =>
            groupSelection.optionIds.some(
              (oid) => oid.toString() === opt._id.toString()
            )
          );
          return {
            groupId: vg._id,
            groupName: vg.name,
            options: chosenOptions.map((opt) => ({
              id: opt._id,
              name: opt.name,
              price: opt.price,
            })),
          };
        });

      const basePrice =
        selectedVariants.find((v) => v.option)?.option?.price || 0;
      const addonsTotal = selectedVariants
        .filter((v) => v.options)
        .flatMap((v) => v.options || [])
        .reduce((sum, opt) => sum + opt.price, 0);

      const unitPrice = basePrice + addonsTotal;
      const lineTotal = unitPrice * quantity;

      return {
        productId: productId._id,
        productName: productId.name,
        productImage: productId.image,
        quantity,
        selectedVariants,
        pricing: {
          basePrice,
          addonsTotal,
          unitPrice,
          lineTotal,
        },
      };
    });

    const subtotal = orderItems.reduce(
      (sum, i) => sum + i.pricing.lineTotal,
      0
    );
    const tax = 0;
    const deliveryFee = 250;
    const grandTotal = subtotal + tax + deliveryFee;

    const payment = {
      method: req.body?.payment?.method || "COD",
      transactionId: req.body?.payment?.transactionId || null,
      status: req.body?.payment?.status || "pending",
    };

    const order = new Order({
      userId,
      items: orderItems,
      orderSummary: { subtotal, tax, deliveryFee, grandTotal },
      payment,
    });

    await Notification.create({
      type: "order",
      title: "Order created!",
      message: `Your order has been created! Please check order section to track your order.`,
      userId,
    });

    await order.save();
    await Cart.findOneAndDelete({ userId });
    await CartItem.deleteMany({ cartId: cart._id });
    return res.status(201).json({
      message: "Order created successfully",
      order,
    });
  } catch (error) {
    console.log(error);
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getAllOrders = async (req, res, next) => {
  try {
    const orders = await Order.find({}).sort({ createdAt: -1 });
    res.status(200).json({ status: 200, orders });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getSingleOrder = async (req, res, next) => {
  const { id } = req.params;
  try {
    const order = await Order.findById(id).sort({ createdAt: -1 });
    res.status(200).json({ status: 200, order });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const updateOrder = async (req, res, next) => {
  const { id } = req.params;
  const userId = req.user._id;
  const { status } = req.body;
  try {
    const order = await Order.findByIdAndUpdate(id, { status }, { new: true });
    await Notification.create({
      userId,
      type: "order",
      title: "Order update!",
      message: `Your order has been ${status}!`,
    });
    await Log.create({
      type: "admin",
      title: "Order updated",
      message: `Order ${order._id} updated by ${req.user.name} to ${status}!`,
    });
    res.status(200).json({ status: 200, order });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};
