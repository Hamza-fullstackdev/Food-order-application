import mongoose from "mongoose";

const categorySchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: [true, "User is required"],
    },
    name: {
      type: String,
      required: [true, "Name is required"],
      trim: true,
      unique: [true, "Category name already exists"],
    },
    image: {
      type: String,
      trim: true,
    },
    imageId: {
      type: String,
      trim: true,
    },
  },
  { timestamps: true }
);

categorySchema.index({ createdAt: -1 });
const Category = mongoose.model("Category", categorySchema);
export default Category;
