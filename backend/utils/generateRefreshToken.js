import jwt from "jsonwebtoken";
import { config } from "./config.js";

const generateRefreshToken = async (userId) => {
  const refreshToken = jwt.sign({ userId }, config.JWT_SECRET_KEY, {
    expiresIn: "7d",
  });
  return refreshToken;
};

export default generateRefreshToken;
