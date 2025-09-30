import mongoose, { Schema } from "mongoose";

const OrderSchema = new mongoose.Schema(
  {
    userId: { type: Schema.Types.ObjectId, ref: "User", required: true },
    items: [
      {
        productId: { type: String, required: true },
        productName: { type: String, required: true },
        productImage: { type: String, required: true },
        quantity: { type: Number, required: true },
        selectedVariants: [
          {
            groupId: { type: String, required: true },
            groupName: { type: String, required: true },
            option: {
              id: { type: String },
              name: { type: String },
              price: { type: Number },
            },
            options: [
              {
                id: { type: String },
                name: { type: String },
                price: { type: Number },
              },
            ],
          },
        ],
        pricing: {
          basePrice: { type: Number, required: true },
          addonsTotal: { type: Number, required: true },
          unitPrice: { type: Number, required: true },
          lineTotal: { type: Number, required: true },
        },
      },
    ],
    orderSummary: {
      subtotal: { type: Number, required: true },
      tax: { type: Number, required: true },
      deliveryFee: { type: Number, required: true },
      grandTotal: { type: Number, required: true },
    },
    status: {
      type: String,
      enum: ["pending", "confirmed", "shipped", "delivered", "cancelled"],
      default: "pending",
    },
    payment: {
      method: { type: String, enum: ["COD", "Card"], required: true, default: "COD" },
      transactionId: { type: String },
      status: {
        type: String,
        enum: ["pending", "paid", "failed", "refunded"],
        default: "pending",
      },
    },
  },
  { timestamps: true }
);

const Order = mongoose.models.Order || mongoose.model("Order", OrderSchema);

export default Order;
