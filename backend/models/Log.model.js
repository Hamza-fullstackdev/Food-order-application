import mongoose from "mongoose";

const logScheama = new mongoose.Schema(
  {
    type: {
      type: String,
      enum: ["app", "admin"],
      required: [true, "Type is required"],
    },
    title: {
      type: String,
      required: [true, "Title is required"],
    },
    message: {
      type: String,
      required: [true, "Message is required"],
    },
  },
  { timestamps: true }
);

logScheama.index({ createdAt: -1 });

const Log = mongoose.model("Log", logScheama);
export default Log;
