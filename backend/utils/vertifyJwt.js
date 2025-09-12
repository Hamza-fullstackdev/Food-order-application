import jwt from "jsonwebtoken";
import { config } from "./config.js";
import User from "../models/User.model.js";
import errorHandler from "../middleware/error.middleware.js";

const verifyJwt = async (req, res, next) => {
  try {
    const token = req.headers.authorization.split(" ")[1];
    const decoded = jwt.verify(token, config.JWT_SECRET_KEY);
    req.user = await User.findOne({ _id: decoded.userId });
    next();
  } catch (error) {
    next(errorHandler(401, "Unauthorized"));
  }
};

export default verifyJwt;
