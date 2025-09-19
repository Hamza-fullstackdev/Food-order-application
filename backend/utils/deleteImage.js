import { v2 as cloudinary } from "cloudinary";

export const deleteImageFromCloudinary = async (publicId) => {
  try {
    if (!publicId) return;

    const result = await cloudinary.uploader.destroy(publicId);
    return result;
  } catch (error) {
    console.error("Cloudinary deletion error:", error);
    throw new Error("Failed to delete image from Cloudinary");
  }
};
