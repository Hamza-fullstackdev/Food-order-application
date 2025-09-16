import Subcategory from "../models/Subcategory.model.js";
import "../models/Category.model.js";
import errorHandler from "../middleware/error.middleware.js";


export const addSubcategory = async (req, res, next) => {
  const { name, categoryId } = req.body;
  try {
    const subcategory = await Subcategory.create({ name, categoryId });
    res
      .status(200)
      .json({
        status: 200,
        message: "Subcategory added successfully",
        subcategory,
      });
  } catch (error) {
    if (error.name === "ValidationError") {
      const messages = Object.values(error.errors).map((val) => val.message);
      return next(errorHandler(400, messages.join(", ")));
    }
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getAllSubcategories = async (req, res, next) => {
  try {
    const subcategories = await Subcategory.find({}).populate("categoryId");
    res.status(200).json({ status: 200, subcategories });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getSingleSubcategory = async (req, res, next) => {
  const { id } = req.params;
  try {
    const subcategory = await Subcategory.findById(id).populate("categoryId");
    res.status(200).json({ status: 200, subcategory });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};
