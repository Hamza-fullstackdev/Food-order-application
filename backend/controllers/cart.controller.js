import Cart from "../models/Cart.model.js";
import CartItem from "../models/CartItem.model.js";
import errorHandler from "../middleware/error.middleware.js";
import "../models/Product.model.js";
export const addToCart = async (req, res, next) => {
  const { productId, quantity } = req.body;
  const userId = req.user._id;

  try {
    const cart = await Cart.findOne({ userId });
    if (!cart) {
      const newCart = await Cart.create({ userId });
      const cartItem = await CartItem.create({
        productId,
        quantity,
        cartId: newCart._id,
      });
      res.status(200).json({
        status: 200,
        message: "Product added to cart successfully",
        cartItem,
      });
    } else {
      const cartItem = await CartItem.create({
        productId,
        quantity,
        cartId: cart._id,
      });
      res.status(200).json({
        status: 200,
        message: "Product added to cart successfully",
        cartItem,
      });
    }
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
}
export const getCart = async (req, res, next) => {
  const userId = req.user._id;
  try {
    const cart = await Cart.findOne({ userId });
    if (!cart) {
      return next(errorHandler(404, "Cart not found against this user"));
    }
    const cartItems = await CartItem.find({ cartId: cart._id })
      .select("-cartId")
      .populate("productId");
    res.status(200).json({ status: 200, cartItems });
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
