import mongoose from "mongoose";

const ratingSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: [true, "User is required"],
    },
    productId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Product",
      required: [true, "Product is required"],
      index: true,
    },
    rating: {
      type: Number,
      required: [true, "Rating is required"],
      min: [1, "Rating must be between 1 and 5"],
      max: [5, "Rating must be between 1 and 5"],
    },
    comment: {
      type: String,
      required: [true, "Comment is required"],
    },
  },
  { timestamps: true }
);

ratingSchema.index({ productId: 1, createdAt: -1 });
const Rating = mongoose.models.Rating || mongoose.model("Rating", ratingSchema);
export default Rating;
