import dotenv from "dotenv";

dotenv.config();
const _config = {
    MONGODB_URI: process.env.MONGODB_URI,
    PORT: process.env.PORT,
    DATABASE: process.env.DATABASE,
    JWT_SECRET_KEY: process.env.JWT_SECRET_KEY,
    CLOUDINARY_NAME: process.env.CLOUDINARY_NAME,
    CLOUDINARY_API_KEY: process.env.CLOUDINARY_API_KEY,
    CLOUDINARY_API_SECRET: process.env.CLOUDINARY_API_SECRET
}

export const config = Object.freeze(_config)