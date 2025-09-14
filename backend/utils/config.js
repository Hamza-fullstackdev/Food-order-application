import dotenv from "dotenv";

dotenv.config();
const _config = {
    MONGODB_URI: process.env.MONGODB_URI,
    PORT: process.env.PORT,
    DATABASE: process.env.DATABASE,
    JWT_SECRET_KEY: process.env.JWT_SECRET_KEY
}

export const config = Object.freeze(_config)