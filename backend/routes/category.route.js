import express from "express";
import {
  addCategory,
  getAllCategories,
  getSingleCategory,
  deleteCategory,
  updateCategory,
} from "../controllers/category.controller.js";
import verifyJwt from "../utils/vertifyJwt.js";
import upload from "../utils/multer.js";

const router = express.Router();

router.post("/add-category", verifyJwt, upload.single("image"), addCategory);
router.patch(
  "/update-category/:id",
  verifyJwt,
  upload.single("image"),
  updateCategory
);
router.get("/get-all-categories", verifyJwt, getAllCategories);
router.get("/get-category/:id", verifyJwt, getSingleCategory);
router.delete("/delete-category/:id", verifyJwt, deleteCategory);

export default router;
