import Cart from "../models/Cart.model.js";
import CartItem from "../models/CartItem.model.js";
import errorHandler from "../middleware/error.middleware.js";
import "../models/Product.model.js";
import Product from "../models/Product.model.js";

export const addToCart = async (req, res, next) => {
  const { productId, quantity, selectedOptions } = req.body;
  const userId = req.user._id;

  try {
    const product = await Product.findById(productId);
    if (!product) {
      return res.status(404).json({ message: "Product not found" });
    }

    for (const selection of selectedOptions) {
      const group = product.variantGroups.find(
        (g) => g._id.toString() === selection.variantGroupId.toString()
      );
      if (!group) {
        return res.status(400).json({
          message: `Invalid variant group: ${selection.variantGroupId}`,
        });
      }

      for (const optId of selection.optionIds) {
        const option = group.options.find(
          (o) => o._id.toString() === optId.toString()
        );
        if (!option) {
          return res.status(400).json({
            message: `Invalid option ${optId} for group ${group.name}`,
          });
        }
      }
    }

    let cart = await Cart.findOne({ userId });
    if (!cart) {
      cart = await Cart.create({ userId });
    }

    const cartItem = await CartItem.create({
      cartId: cart._id,
      productId,
      quantity,
      selectedOptions,
    });

    res.status(200).json({
      status: 200,
      message: "Product added to cart successfully",
      cartItem,
    });
  } catch (error) {
    if (error.code === 11000) {
      return next(errorHandler(400, "Product already added to cart"));
    } else {
      next(errorHandler(500, "Something went wrong, please try again later"));
    }
  }
};

export const updateCart = async (req, res, next) => {
  const { id } = req.params;
  const { quantity } = req.body;
  try {
    await CartItem.findByIdAndUpdate(id, { quantity });
    res.status(200).json({ status: 200, message: "Cart updated successfully" });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getCart = async (req, res, next) => {
  const userId = req.user._id;

  try {
    const cart = await Cart.findOne({ userId });
    if (!cart) {
      return next(errorHandler(404, "Cart not found against this user"));
    }

    const cartItems = await CartItem.find({ cartId: cart._id })
      .select("-cartId")
      .populate({
        path: "productId",
        select: "name image variantGroups",
      });

    const formattedCartItems = cartItems.map((item) => {
      const product = item.productId ? item.productId.toObject() : {};
      const selectedOptions = item.selectedOptions || [];

      const filteredGroups = (product.variantGroups || [])
        .filter((group) =>
          selectedOptions.some(
            (sel) => sel.variantGroupId.toString() === group._id.toString()
          )
        )
        .map((group) => {
          const selectedGroup = selectedOptions.find(
            (sel) => sel.variantGroupId.toString() === group._id.toString()
          );

          return {
            _id: group._id,
            name: group.name,
            options: group.options.filter((opt) =>
              selectedGroup.optionIds.some(
                (selOptId) => selOptId.toString() === opt._id.toString()
              )
            ),
          };
        });

      return {
        _id: item._id,
        quantity: item.quantity,
        product: {
          ...product,
          variantGroups: filteredGroups,
        },
      };
    });

    res.status(200).json({ status: 200, cartItems: formattedCartItems });
  } catch (error) {
    console.log(error);
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const removeFromCart = async (req, res, next) => {
  const { id } = req.params;
  try {
    await CartItem.findByIdAndDelete(id);
    res.status(200).json({ status: 200, message: "Product removed from cart" });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};
