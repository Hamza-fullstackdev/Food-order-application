import errorHandler from "../middleware/error.middleware.js";
import User from "../models/User.model.js";
import { hashPassword } from "../utils/hashedPassword.js";
export const getAllUsers = async (req, res, next) => {
  try {
    const users = await User.find({})
      .sort({ createdAt: -1 })
      .select("-password");
    res.status(200).json({ status: 200, users });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getSingleUser = async (req, res, next) => {
  const { id } = req.params;
  try {
    const user = await User.findById(id).select("-password");
    res.status(200).json({ status: 200, user });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const updateUser = async (req, res, next) => {
  const { id } = req.params;
  const { password } = req.body;

  if (password) {
    const hashedPassword = await hashPassword(password);
    req.body.password = hashedPassword;
  }
  try {
    const user = await User.findByIdAndUpdate(id, req.body, { new: true });
    res.status(200).json({ status: 200, user });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const deleteUser = async (req, res, next) => {
  const { id } = req.params;
  try {
    await User.findByIdAndDelete(id);
    res.status(200).json({ status: 200, message: "User deleted successfully" });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};
