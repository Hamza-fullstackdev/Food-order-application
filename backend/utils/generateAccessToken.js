import jwt from "jsonwebtoken";
import { config } from "./config.js";

const generateAccessToken = async (userId) => {
    const accessToken = jwt.sign({ userId }, config.JWT_SECRET_KEY, {
        expiresIn: "15m",
    });
    return accessToken;
};

export default generateAccessToken;