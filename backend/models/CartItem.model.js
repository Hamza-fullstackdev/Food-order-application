import mongoose from "mongoose";

const cartItemScheama = new mongoose.Schema(
  {
    cartId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Cart",
      required: [true, "Cart is required"],
      index: true,
    },
    productId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Product",
      required: [true, "Product is required"],
    },
    selectedOptions: [
      {
        variantGroupId: {
          type: mongoose.Schema.Types.ObjectId,
          required: true,
        },
        optionIds: [
          {
            type: mongoose.Schema.Types.ObjectId,
            required: true,
          },
        ],
      },
    ],
    quantity: {
      type: Number,
      required: [true, "Quantity is required"],
      min: [1, "Quantity must be at least 1"],
    },
    comboKey: { type: String, required: true, index: true },
  },
  {
    timestamps: true,
  }
);

cartItemScheama.index({ cartId: 1, createdAt: -1 });
const CartItem =
  mongoose.models.CartItem || mongoose.model("CartItem", cartItemScheama);
export default CartItem;
