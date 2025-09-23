import Category from "../models/Category.model.js";
import Subcategory from "../models/Subcategory.model.js";
import Product from "../models/Product.model.js";
import errorHandler from "../middleware/error.middleware.js";
import uploadCategoryImage from "../utils/uploadCategory.js";
import { deleteImageFromCloudinary } from "../utils/deleteImage.js";
import { v2 as cloudinary } from "cloudinary";
import Log from "../models/Log.model.js";

export const addCategory = async (req, res, next) => {
  const { name } = req.body;
  const userId = req.user._id;

  if (!name) {
    return next(errorHandler(400, "All fields are required"));
  }
  try {
    const isCategoryExist = await Category.findOne({
      name: name.toLowerCase(),
    });
    if (isCategoryExist) {
      return next(errorHandler(400, "Category already exists"));
    }
    const uploaded_img = await uploadCategoryImage(req.file.path);
    const category = await Category.create({
      name: name.toLowerCase(),
      image: uploaded_img.secure_url,
      imageId: uploaded_img.public_id,
      userId,
    });
    await Log.create({
      type: "admin",
      title: "Category added",
      message: `Category ${category.name} added by ${req.user.name}`,
    });
    res
      .status(200)
      .json({ status: 200, message: "Category added successfully", category });
  } catch (error) {
    if (error.name === "ValidationError") {
      const messages = Object.values(error.errors).map((val) => val.message);
      return next(errorHandler(400, messages.join(", ")));
    }
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const updateCategory = async (req, res, next) => {
  const { id } = req.params;
  const { name } = req.body;

  try {
    const category = await Category.findById(id);
    if (!category) {
      return next(errorHandler(400, "Category does not exist"));
    }

    if (name) {
      category.name = name.toLowerCase();
    }

    if (req.file) {
      if (category.imageId) {
        await cloudinary.uploader.destroy(category.imageId);
      }

      const uploaded_img = await uploadCategoryImage(req.file.path);
      category.image = uploaded_img.secure_url;
      category.imageId = uploaded_img.public_id;
    }

    await category.save();
    await Log.create({
      type: "admin",
      title: "Category updated",
      message: `Category ${category.name} updated by ${req.user.name}`,
    });
    res.status(200).json({
      status: 200,
      message: "Category updated successfully",
      category,
    });
  } catch (error) {
    console.error("Update category error:", error);

    if (error.name === "ValidationError") {
      const messages = Object.values(error.errors).map((val) => val.message);
      return next(errorHandler(400, messages.join(", ")));
    }

    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getAllCategories = async (req, res, next) => {
  try {
    const categories = await Category.find({}).sort({ createdAt: -1 });
    res.status(200).json({ status: 200, categories });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getSingleCategory = async (req, res, next) => {
  const { id } = req.params;
  try {
    const category = await Category.findById(id);
    res.status(200).json({ status: 200, category });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const deleteCategory = async (req, res, next) => {
  const { id } = req.params;
  try {
    const category = await Category.findById(id);

    if (!category) {
      return next(errorHandler(400, "Category does not exist"));
    }
    await deleteImageFromCloudinary(category.imageId);
    await Category.findByIdAndDelete(id);
    await Subcategory.deleteMany({ categoryId: id });
    await Product.deleteMany({ categoryId: id });
    await Log.create({
      type: "admin",
      title: "Category deleted",
      message: `Category ${category.name} deleted by ${req.user.name}`,
    });
    res
      .status(200)
      .json({ status: 200, message: "Category deleted successfully" });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};
