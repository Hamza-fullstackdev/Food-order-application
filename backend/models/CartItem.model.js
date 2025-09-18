import mongoose from "mongoose";

const cartItemScheama = new mongoose.Schema(
  {
    cartId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Cart",
      required: [true, "Cart is required"],
    },
    productId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Product",
      required: [true, "Product is required"],
    },
    quantity: {
      type: Number,
      required: [true, "Quantity is required"],
      min: [1, "Quantity must be at least 1"],
    },
  },
  {
    timestamps: true,
  }
);

const CartItem =
  mongoose.models.CartItem || mongoose.model("CartItem", cartItemScheama);
export default CartItem;
