import errorHandler from "../middleware/error.middleware.js";
import isValidEmail from "../utils/checkEmail.js";
import containsOnlyNumbers from "../utils/checkPhone.js";
import { hashPassword, comparePassword } from "../utils/hashedPassword.js";
import generateAccessToken from "../utils/generateAccessToken.js";
import generateRefreshToken from "../utils/generateRefreshToken.js";
import User from "../models/User.model.js";
import jwt from "jsonwebtoken";
import { config } from "../utils/config.js";
import uploadUserImage from "../utils/uploadUser.js";
import { deleteImageFromCloudinary } from "../utils/deleteImage.js";
import Notification from "../models/Notification.model.js";
import Log from "../models/Log.model.js";

export const register = async (req, res, next) => {
  const { name, email, password, phoneNumber, isAdmin } = req.body;

  if (!name || !email || !password) {
    return next(errorHandler(400, "All fields are required"));
  }
  const isEmailExist = await User.findOne({ email });
  if (isEmailExist) {
    return next(errorHandler(400, "Email already exists"));
  }
  if (!isValidEmail(email)) {
    return next(errorHandler(400, "Please enter valid email"));
  }
  if (phoneNumber) {
    const isPhoneExist = await User.findOne({ phoneNumber });
    if (isPhoneExist) {
      return next(errorHandler(400, "Phone number already exists"));
    }
    if (!containsOnlyNumbers(phoneNumber)) {
      return next(errorHandler(400, "Please enter valid phone number"));
    }
  }

  let encryptedPassword;
  try {
    if (password.length >= 8) {
      encryptedPassword = await hashPassword(password);
    } else {
      return next(
        errorHandler(400, "Password should be at least 8 characters long")
      );
    }
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }

  let uploaded_img;
  if (req.file) {
    try {
      uploaded_img = await uploadUserImage(req.file.path);
    } catch (error) {
      next(errorHandler(500, "Something went wrong, please try again later"));
    }
  }
  try {
    const newUser = new User({
      name,
      email,
      password: encryptedPassword,
      phoneNumber,
      profileImage: uploaded_img?.secure_url,
      profileImageId: uploaded_img?.public_id,
      isAdmin,
    });
    await Notification.create({
      userId: newUser._id,
      type: "register",
      title: `Welcome aboard ${newUser.name}!`,
      message: "Your account has been created successfully",
    });
    await newUser.save();
    res
      .status(201)
      .json({ status: 201, message: "User registered successfully" });
  } catch (error) {
    if (error.name === "ValidationError") {
      const messages = Object.values(error.errors).map((val) => val.message);
      return next(errorHandler(400, messages.join(", ")));
    }
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const login = async (req, res, next) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return next(errorHandler(400, "All fields are required"));
  }

  try {
    const user = await User.findOne({ email });
    if (!user) {
      return next(errorHandler(400, "User not found"));
    }
    const isMatch = await comparePassword(password, user.password);
    if (!isMatch) {
      return next(errorHandler(400, "Invalid credentials"));
    }
    const refreshToken = await generateRefreshToken(user._id);
    const accessToken = await generateAccessToken(user._id);

    const refreshExpiry = new Date();
    refreshExpiry.setDate(refreshExpiry.getDate() + 7);
    if (user.refreshToken && user.refreshToken.length > 0) {
      user.refreshToken[0] = { token: refreshToken, expiresAt: refreshExpiry };
    } else {
      user.refreshToken.push({ token: refreshToken, expiresAt: refreshExpiry });
    }
    await Notification.create({
      userId: user._id,
      type: "login",
      title: `Welcome back ${user.name}!`,
      message: "We are glad to see you again",
    });
    await user.save();
    res.status(200).json({
      status: 200,
      message: "Logged in successfully",
      user: {
        _id: user._id,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        profileImage: user.profileImage,
        isAdmin: user.isAdmin,
        accessToken,
        refreshToken,
      },
    });
  } catch (error) {
    console.log(error);
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const adminLogin = async (req, res, next) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return next(errorHandler(400, "All fields are required"));
  }

  try {
    const user = await User.findOne({ email, isAdmin: true });
    if (!user) {
      return next(errorHandler(400, "Seems like you are not an admin :("));
    }
    const isMatch = await comparePassword(password, user.password);
    if (!isMatch) {
      return next(errorHandler(400, "Invalid credentials"));
    }
    if (user.isBlocked) {
      return next(
        errorHandler(
          400,
          "You are temporarily blocked by the admin, Apologize Hami first (if you did something wrong) and then try again :) "
        )
      );
    }
    const refreshToken = await generateRefreshToken(user._id);
    const accessToken = await generateAccessToken(user._id);

    const refreshExpiry = new Date();
    refreshExpiry.setDate(refreshExpiry.getDate() + 7);
    if (user.refreshToken && user.refreshToken.length > 0) {
      user.refreshToken[0] = { token: refreshToken, expiresAt: refreshExpiry };
    } else {
      user.refreshToken.push({ token: refreshToken, expiresAt: refreshExpiry });
    }

    await Log.create({
      type: "admin",
      title: "Logged in",
      message: `${user.email} logged in`,
    });
    await user.save();
    res.status(200).json({
      status: 200,
      message: "Logged in successfully",
      user: {
        _id: user._id,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        profileImage: user.profileImage,
        isAdmin: user.isAdmin,
        accessToken,
        refreshToken,
      },
    });
  } catch (error) {
    console.log(error);
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const logout = async (req, res, next) => {
  const user = req.user;
  try {
    user.refreshToken = [];
    await Notification.create({
      userId: user._id,
      type: "logout",
      title: `Goodbye ${user.name}!`,
      message: "We hope to see you again soon",
    });
    await user.save();
    res.status(200).json({ status: 200, message: "Logged out successfully" });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const refreshToken = async (req, res, next) => {
  const token = req.headers.authorization?.split(" ")[1];
  if (!token) {
    return next(errorHandler(400, "Refresh token is required"));
  }

  try {
    const decoded = jwt.verify(token, config.JWT_SECRET_KEY);
    const user = await User.findById(decoded.userId);

    if (!user) {
      return next(errorHandler(404, "User not found"));
    }

    const storedToken = user.refreshToken[0];

    if (!storedToken || storedToken.token !== token) {
      return next(errorHandler(403, "Invalid refresh token"));
    }

    if (new Date() > storedToken.expiresAt) {
      user.refreshToken = [];
      await user.save();
      return next(
        errorHandler(401, "Refresh token expired, please login again")
      );
    }

    const refreshToken = await generateRefreshToken(user._id);
    const expiresAt = new Date();
    expiresAt.setDate(expiresAt.getDate() + 7);

    user.refreshToken = [{ token: refreshToken, expiresAt }];
    await user.save();

    const accessToken = await generateAccessToken(user._id);

    res.status(200).json({
      status: 200,
      message: "Token refreshed successfully",
      user: {
        _id: user._id,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        profileImage: user.profileImage,
        isAdmin: user.isAdmin,
        refreshToken,
        accessToken,
      },
    });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const deleteUser = async (req, res, next) => {
  const user = req.user;

  try {
    const isUserExist = await User.findById(user._id);
    if (!isUserExist) {
      return next(errorHandler(404, "User not found"));
    }
    const deletedImage = await deleteImageFromCloudinary(
      isUserExist.profileImageId
    );
    if (deletedImage) {
      await User.findByIdAndDelete(user._id);
    }
    res.status(200).json({ status: 200, message: "User deleted successfully" });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const getLogs = async (req, res, next) => {
  try {
    const logs = await Log.find({}).sort({ createdAt: -1 });
    res.status(200).json({ status: 200, logs });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};
