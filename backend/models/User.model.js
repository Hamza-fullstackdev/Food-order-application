import mongoose from "mongoose";

const userScheama = new mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, "Name is required"],
      trim: true,
      minlength: [3, "Name must be at least 3 characters long"],
      maxlength: [25, "Name cannot exceed 25 characters"],
    },
    email: {
      type: String,
      required: [true, "Email is required"],
      unique: [true, "Email already exists"],
      trim: true,
      lowercase: true,
    },
    password: {
      type: String,
      required: [true, "Password is required"],
      minlength: [8, "Password must be at least 8 characters long"],
    },
    profileImage: {
      type: String,
      default:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ87KJTvoZmlpQo-zqqQqFPbUXHqBnJt8xDZg&s",
    },
    profileImageId: {
      type: String,
    },
    phoneNumber: {
      type: String,
      trim: true,
      minlength: [10, "Please enter a valid phone number"],
    },
    isAdmin: {
      type: Boolean,
      required: true,
      default: false,
    },
    isBlocked: {
      type: Boolean,
      required: true,
      default: false,
    },
    refreshToken: [
      {
        token: { type: String, required: true },
        expiresAt: { type: Date, required: true },
      },
    ],
  },
  {
    timestamps: true,
  }
);

userScheama.index({ createdAt: -1 });
const User = mongoose.models.User || mongoose.model("User", userScheama);
export default User;
