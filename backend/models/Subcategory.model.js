import mongoose from "mongoose";

const subcategorySchema = new mongoose.Schema(
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
      unique: [true, "Subcategory name already exists"],
    },
    categoryId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Category",
      required: [true, "Category is required"],
    },
  },
  { timestamps: true }
);

subcategorySchema.index({ createdAt: -1 });

const Subcategory = mongoose.model("Subcategory", subcategorySchema);
export default Subcategory;
