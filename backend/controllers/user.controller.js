import errorHandler from "../middleware/error.middleware.js";
import User from "../models/User.model.js";
import Category from "../models/Category.model.js";
import Subcategory from "../models/Subcategory.model.js";
import Product from "../models/Product.model.js";
import Rating from "../models/Rating.model.js";
import Cart from "../models/Cart.model.js";
import CartItem from "../models/CartItem.model.js";
import { hashPassword } from "../utils/hashedPassword.js";
export const getAllUsers = async (req, res, next) => {
  try {
    const users = await User.find({})
      .sort({ createdAt: -1 })
      .select("-password");
    res.status(200).json({ status: 200, users });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getSingleUser = async (req, res, next) => {
  const { id } = req.params;
  try {
    const user = await User.findById(id).select("-password");
    const categories = await Category.find({ userId: id }).sort({
      createdAt: -1,
    });
    const subcategories = await Subcategory.find({ userId: id })
      .sort({
        createdAt: -1,
      })
      .populate("categoryId");
    const products = await Product.find({ userId: id }).sort({ createdAt: -1 });
    const ratings = await Rating.find({ userId: id }).populate("productId");
    const cart = await Cart.findOne({ userId: id });
    const response = {
      user,
      categories,
      subcategories,
      products,
      ratings,
    };
    if (cart) {
      const cartItems = await CartItem.find({ cartId: cart._id }).populate(
        "productId"
      );
      response.cartItems = cartItems;
    }
    res.status(200).json({ status: 200, response });
  } catch (error) {
    console.log(error);
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const updateUser = async (req, res, next) => {
  const { id } = req.params;
  const { password } = req.body;

  if (password) {
    const hashedPassword = await hashPassword(password);
    req.body.password = hashedPassword;
  }
  try {
    const user = await User.findByIdAndUpdate(id, req.body, { new: true });
    res.status(200).json({ status: 200, user });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const deleteUser = async (req, res, next) => {
  const { id } = req.params;
  try {
    await User.findByIdAndDelete(id);
    res.status(200).json({ status: 200, message: "User deleted successfully" });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};
