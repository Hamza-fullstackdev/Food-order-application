import Product from "../models/Product.model.js";
import errorHandler from "../middleware/error.middleware.js";
import uploadImage from "../utils/upload.js";

export const addProduct = async (req, res, next) => {
  const { name, shortDescription, description, price } = req.body;
  const userId = req.user._id;

  if (!name || !shortDescription || !description || !price) {
    return next(errorHandler(400, "All fields are required"));
  }
  try {
    const uploaded_img = await uploadImage(req.file.path);
    const product = await Product.create({
      userId,
      name,
      shortDescription,
      description,
      price,
      image: uploaded_img.secure_url,
    });
    res
      .status(200)
      .json({ status: 200, message: "Product added successfully", product });
  } catch (error) {
    if (error.name === "ValidationError") {
      const messages = Object.values(error.errors).map((val) => val.message);
      return next(errorHandler(400, messages.join(", ")));
    }
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getAllProducts = async (req, res, next) => {
  try {
    const products = await Product.find({});
    res.status(200).json({ status: 200, products });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getSingleProduct = async (req, res, next) => {
  const { id } = req.params;
  try {
    const product = await Product.findById(id);
    res.status(200).json({ status: 200, product });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getAllProductsByUser = async (req, res, next) => {
  const userId = req.user._id;
  try {
    const products = await Product.find({ userId });
    res.status(200).json({ status: 200, products });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};
