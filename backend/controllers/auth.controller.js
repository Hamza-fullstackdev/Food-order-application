import errorHandler from "../middleware/error.middleware.js";
import isValidEmail from "../utils/checkEmail.js";
import containsOnlyNumbers from "../utils/checkPhone.js";
import { hashPassword, comparePassword } from "../utils/hashedPassword.js";
import generateAccessToken from "../utils/generateAccessToken.js";
import generateRefreshToken from "../utils/generateRefreshToken.js";
import User from "../models/User.model.js";
import jwt from "jsonwebtoken";
import { config } from "../utils/config.js";

export const register = async (req, res, next) => {
  const { name, email, password, phoneNumber, profileImage, isAdmin } =
    req.body;

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

  try {
    const newUser = new User({
      name,
      email,
      password: encryptedPassword,
      phoneNumber,
      profileImage,
      isAdmin,
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
    await user.save();
    res.status(200).json({ status: 200, message: "Logged out successfully" });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};

export const refreshToken = async (req, res, next) => {
  const refreshToken = req.headers.authorization.split(" ")[1];
  if (!refreshToken) {
    return next(errorHandler(400, "Refresh token is required"));
  }
  try {
    const decoded = jwt.verify(refreshToken, config.JWT_SECRET_KEY);
    const user = await User.findOne({ _id: decoded.userId });
    if (!user) {
      return next(errorHandler(400, "User not found"));
    }
    const newAccessToken = await generateAccessToken(user._id);
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
        accessToken: newAccessToken,
      },
    });
  } catch (error) {
    next(errorHandler(500, "Something went wrong, please try again later"));
  }
};
