import Cart from "../models/Cart.model.js";
import CartItem from "../models/CartItem.model.js";
import errorHandler from "../middleware/error.middleware.js";
import "../models/Product.model.js";
import Product from "../models/Product.model.js";

export const addToCart = async (req, res, next) => {
  const { productId, quantity, selectedOptions } = req.body;
  const userId = req.user._id;

  try {
    const product = await Product.findById(productId).lean();
    if (!product) {
      return next(errorHandler(404, "Product not found"));
    }

    const groupMap = new Map(
      product.variantGroups.map((g) => [g._id.toString(), g])
    );

    for (const sel of selectedOptions) {
      const group = groupMap.get(sel.variantGroupId.toString());
      if (!group) {
        return next(
          errorHandler(400, `Invalid variant group: ${sel.variantGroupId}`)
        );
      }

      const validOptionIds = new Set(
        group.options.map((o) => o._id.toString())
      );
      for (const optId of sel.optionIds) {
        if (!validOptionIds.has(optId.toString())) {
          return next(
            errorHandler(400, `Invalid option ${optId} for group ${group.name}`)
          );
        }
      }
    }

    let cart = await Cart.findOne({ userId });
    if (!cart) cart = await Cart.create({ userId });

    const comboKey = [
      productId,
      ...selectedOptions
        .map(
          (s) =>
            `${s.variantGroupId}:${s.optionIds
              .map((id) => id.toString())
              .sort()
              .join(",")}`
        )
        .sort(),
    ].join("|");

    const existingItem = await CartItem.findOne({
      cartId: cart._id,
      comboKey,
    }).lean();

    if (existingItem) {
      return next(
        errorHandler(
          400,
          "You already added this combination to your cart. Please update the quantity."
        )
      );
    }

    const cartItem = await CartItem.create({
      cartId: cart._id,
      productId,
      quantity,
      selectedOptions,
      comboKey,
    });

    res.status(200).json({
      status: 200,
      message: "Product added to cart successfully",
      cartItem,
    });
  } catch (error) {
    console.error(error);
    next(
      errorHandler(
        500,
        "Something went wrong while adding to cart, please try again later"
      )
    );
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

      const selectedMap = new Map(
        selectedOptions.map((sel) => [
          sel.variantGroupId.toString(),
          sel.optionIds,
        ])
      );

      if (!product.variantGroups?.length || selectedMap.size === 0) {
        return {
          _id: item._id,
          quantity: item.quantity,
          itemTotal: 0,
          product,
        };
      }

      let optionsTotal = 0;
      const filteredGroups = [];

      for (const group of product.variantGroups) {
        const selectedIds = selectedMap.get(group._id.toString());
        if (!selectedIds) continue;

        const selectedIdSet = new Set(selectedIds.map(String));
        const selectedOptionsInGroup = [];

        for (const opt of group.options || []) {
          if (selectedIdSet.has(opt._id.toString())) {
            selectedOptionsInGroup.push(opt);
            optionsTotal += opt.price || 0;
          }
        }

        filteredGroups.push({
          _id: group._id,
          name: group.name,
          options: selectedOptionsInGroup,
        });
      }

      const itemTotal = optionsTotal * item.quantity;

      return {
        _id: item._id,
        quantity: item.quantity,
        itemTotal,
        product: {
          ...product,
          variantGroups: filteredGroups,
        },
      };
    });

    res.status(200).json({
      status: 200,
      cartItems: formattedCartItems,
    });
  } catch (error) {
    console.error(error);
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
