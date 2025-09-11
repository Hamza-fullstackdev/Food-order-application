import errorHandler from "../middleware/error.middleware.js";
import isValidEmail from "../utils/checkEmail.js";
import containsOnlyNumbers from "../utils/checkPhone.js";
import hashPassword from "../utils/hashedPassword.js";
import User from "../models/User.model.js";

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
    if (password.length > 8) {
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
