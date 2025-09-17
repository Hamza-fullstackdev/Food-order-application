import Category from "../models/Category.model.js";
import errorHandler from "../middleware/error.middleware.js";

export const addCategory = async (req, res, next) => {
  const { name } = req.body;
  const userId = req.user._id;

  if (!name) {
    return next(errorHandler(400, "All fields are required"));
  }
  try {
    const isCategoryExist = await Category.findOne({ name: name.toLowerCase() });
    if (isCategoryExist) {
      return next(errorHandler(400, "Category already exists"));
    }
    const category = await Category.create({ name: name.toLowerCase(), userId });
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

export const getAllCategories = async (req, res, next) => {
  try {
    const categories = await Category.find({});
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
    await Category.findByIdAndDelete(id);
    res.status(200).json({ status: 200, message: "Category deleted successfully" });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};