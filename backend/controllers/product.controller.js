import Product from "../models/Product.model.js";
import Rating from "../models/Rating.model.js";
import errorHandler from "../middleware/error.middleware.js";
import uploadImage from "../utils/upload.js";
import { deleteImageFromCloudinary } from "../utils/deleteImage.js";
import Notification from "../models/Notification.model.js";
import Log from "../models/Log.model.js";
import User from "../models/User.model.js";
import Category from "../models/Category.model.js";
import Subcategory from "../models/Subcategory.model.js";
import CartItem from "../models/CartItem.model.js";
import { imageTransformer } from "../utils/transformer.js";

export const addProduct = async (req, res, next) => {
  const {
    name,
    shortDescription,
    description,
    price,
    categoryId,
    subcategoryId,
    variantGroups,
  } = req.body;
  const userId = req.user._id;

  if (!name || !shortDescription || !description || !price) {
    return next(errorHandler(400, "All fields are required"));
  }
  try {
    let parsedVariants = [];
    if (variantGroups) {
      try {
        parsedVariants = JSON.parse(variantGroups);
        if (!Array.isArray(parsedVariants)) {
          parsedVariants = [];
        }
      } catch (err) {
        console.warn("Invalid variantGroups JSON:", err);
        parsedVariants = [];
      }
    }
    const uploaded_img = await uploadImage(req.file.path);
    const optimized_img = imageTransformer(uploaded_img.secure_url);
    const product = await Product.create({
      userId,
      categoryId,
      subcategoryId,
      name,
      shortDescription,
      description,
      price,
      image: optimized_img,
      imageId: uploaded_img.public_id,
      variantGroups: parsedVariants,
    });
    await Log.create({
      type: "admin",
      title: "Product added",
      message: `Product ${product.name} added by ${req.user.name}`,
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

export const updateProduct = async (req, res, next) => {
  const { id } = req.params;
  const {
    name,
    shortDescription,
    description,
    price,
    categoryId,
    subcategoryId,
  } = req.body;

  try {
    const product = await Product.findById(id);
    if (!product) {
      return next(errorHandler(404, "Product not found"));
    }

    let uploaded_img;
    if (req.file) {
      uploaded_img = await uploadImage(req.file.path);

      if (product.imageId) {
        await deleteImageFromCloudinary(product.imageId);
      }
      const optimized_img = imageTransformer(uploaded_img.secure_url);
      product.image = optimized_img;
      product.imageId = uploaded_img.public_id;
    }

    if (name) product.name = name;
    if (shortDescription) product.shortDescription = shortDescription;
    if (description) product.description = description;
    if (price) product.price = price;
    if (categoryId) product.categoryId = categoryId;
    if (subcategoryId) product.subcategoryId = subcategoryId;

    if (req.body.variantGroups !== undefined) {
      let parsedVariants = [];
      try {
        parsedVariants =
          typeof req.body.variantGroups === "string"
            ? JSON.parse(req.body.variantGroups)
            : req.body.variantGroups;

        if (!Array.isArray(parsedVariants)) {
          parsedVariants = [];
        }
      } catch (err) {
        console.warn("Invalid variantGroups JSON:", err);
        parsedVariants = [];
      }
      product.variantGroups = parsedVariants;
    }

    const updatedProduct = await product.save();
    await Log.create({
      type: "admin",
      title: "Product updated",
      message: `Product ${product.name} updated by ${req.user.name}`,
    });
    res.status(200).json({
      status: 200,
      message: "Product updated successfully",
      product: updatedProduct,
    });
  } catch (error) {
    if (error.name === "ValidationError") {
      const messages = Object.values(error.errors).map((val) => val.message);
      return next(errorHandler(400, messages.join(", ")));
    }
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getByCategory = async (req, res, next) => {
  const { id } = req.params;
  try {
    const products = await Product.find({ categoryId: id }).sort({
      createdAt: -1,
    });
    res.status(200).json({ status: 200, products });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getBySubCategory = async (req, res, next) => {
  const { id } = req.params;
  try {
    const products = await Product.find({ subcategoryId: id }).sort({
      createdAt: -1,
    });
    res.status(200).json({ status: 200, products });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};
export const getAllProducts = async (req, res, next) => {
  try {
    const products = await Product.find({})
      .sort({ createdAt: -1 })
      .populate("subcategoryId")
      .populate("categoryId");
    res.status(200).json({ status: 200, products });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getSingleProduct = async (req, res, next) => {
  const { id } = req.params;
  try {
    const product = await Product.findById(id);
    const reviews = await Rating.find({ productId: id });
    res.status(200).json({ status: 200, product, reviews });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getAllProductsByUser = async (req, res, next) => {
  const userId = req.user._id;
  try {
    const products = await Product.find({ userId }).sort({ createdAt: -1 });
    res.status(200).json({ status: 200, products });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getLatestProducts = async (req, res, next) => {
  try {
    const products = await Product.find({}).sort({ createdAt: -1 }).limit(6);
    res.status(200).json({ status: 200, products });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const deleteProduct = async (req, res, next) => {
  const { id } = req.params;
  try {
    const product = await Product.findById(id);

    if (!product) {
      return next(errorHandler(404, "Product not found"));
    }
    await deleteImageFromCloudinary(product.imageId);
    await Product.findByIdAndDelete(id);
    await Rating.deleteMany({ productId: id });
    await CartItem.deleteMany({ productId: id });
    await Log.create({
      type: "admin",
      title: "Product deleted",
      message: `Product ${product.name} deleted by ${req.user.name}`,
    });
    res
      .status(200)
      .json({ status: 200, message: "Product deleted successfully" });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const addReview = async (req, res, next) => {
  const { productId, rating, comment } = req.body;
  const userId = req.user._id;
  if (!productId || !rating || !comment) {
    return next(errorHandler(400, "All fields are required"));
  }
  try {
    const review = await Rating.create({
      userId,
      productId,
      rating,
      comment,
    });
    await Notification.create({
      userId,
      type: "review",
      title: "Review Added!",
      message: `Thanks for your feedback, we really appreciate it!`,
    });
    await Log.create({
      type: "app",
      title: "Review added",
      message: `Review added by ${req.user.email} for product ${productId}`,
    });
    res
      .status(200)
      .json({ status: 200, message: "Review added successfully", review });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getStatistics = async (req, res, next) => {
  try {
    const products = await Product.find({}).countDocuments();
    const users = await User.find({}).countDocuments();
    const category = await Category.find({}).countDocuments();
    const subcategory = await Subcategory.find({}).countDocuments();
    let data = {
      products,
      users,
      category,
      subcategory,
    };
    res.status(200).json({ status: 200, data });
  } catch (error) {
    console.log(error);
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};
