import mongoose from "mongoose";

const productScheama = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: [true, "User is required"],
      index: true,
    },
    categoryId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Category",
      required: [true, "Category is required"],
      index: true,
    },
    subcategoryId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Subcategory",
    },
    name: {
      type: String,
      required: [true, "Name is required"],
      trim: true,
    },
    shortDescription: {
      type: String,
      required: [true, "Short description is required"],
      trim: true,
    },
    description: {
      type: String,
      required: [true, "Description is required"],
      trim: true,
    },
    price: {
      type: Number,
      required: [true, "Price is required"],
    },
    image: {
      type: String,
      required: [true, "Image is required"],
      trim: true,
    },
    imageId: {
      type: String,
      trim: true,
    },
    variantGroups: [
      {
        name: {
          type: String,
          trim: true,
        },
        isRequired: {
          type: Boolean,
          default: true,
        },
        maxSelectable: {
          type: Number,
          default: 1,
        },
        options: [
          {
            name: {
              type: String,
              required: [true, "Variant name is required"],
              trim: true,
            },
            price: {
              type: Number,
              required: [true, "Variant price is required"],
            },
          },
        ],
      },
    ],
  },
  {
    timestamps: true,
  }
);

productScheama.index({ createdAt: -1 });
const Product =
  mongoose.models.Product || mongoose.model("Product", productScheama);
export default Product;
