import errorHandler from "../middleware/error.middleware.js";
import User from "../models/User.model.js";
import Category from "../models/Category.model.js";
import Subcategory from "../models/Subcategory.model.js";
import Product from "../models/Product.model.js";
import Rating from "../models/Rating.model.js";
import Cart from "../models/Cart.model.js";
import CartItem from "../models/CartItem.model.js";
import { hashPassword } from "../utils/hashedPassword.js";
import { deleteImageFromCloudinary } from "../utils/deleteImage.js";
import uploadUserImage from "../utils/uploadUser.js";
import Notification from "../models/Notification.model.js";
import Log from "../models/Log.model.js";

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
  let updateData = { ...req.body };

  try {
    const user = await User.findById(id);
    if (!user) {
      return next(errorHandler(404, "User not found"));
    }

    if (updateData.password) {
      updateData.password = await hashPassword(updateData.password);
    }

    if (req.file) {
      if (user.profileImageId) {
        await deleteImageFromCloudinary(user.profileImageId);
      }

      const uploadedImg = await uploadUserImage(req.file.path);
      updateData.profileImage = uploadedImg.secure_url;
      updateData.profileImageId = uploadedImg.public_id;
    }

    const updatedUser = await User.findByIdAndUpdate(id, updateData, {
      new: true,
      runValidators: true,
    });
    await Notification.create({
      userId: user._id,
      type: "profile",
      title: `Profile updated!`,
      message: "Your profile changes have been saved",
    });
    res.status(200).json({
      status: 200,
      message: "User updated successfully",
      user: updatedUser,
    });
  } catch (error) {
    console.error(error);
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const deleteUser = async (req, res, next) => {
  const { id } = req.params;
  try {
    const isUserExist = await User.findById(id);
    if (!isUserExist) {
      return next(errorHandler(404, "User not found"));
    }
    await deleteImageFromCloudinary(isUserExist.profileImageId);
    await Notification.deleteMany({ userId: id });
    await User.findByIdAndDelete(id);
    await Log.create({
      type: "app",
      title: "User deleted",
      message: `User deleted by ${req.user.email}`,
    });
    res.status(200).json({ status: 200, message: "User deleted successfully" });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};
