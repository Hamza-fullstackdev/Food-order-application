import express from "express";
import {
  addCategory,
  getAllCategories,
  getSingleCategory,
  deleteCategory
} from "../controllers/category.controller.js";
import verifyJwt from "../utils/vertifyJwt.js";

const router = express.Router();

router.post("/add-category", verifyJwt, addCategory);
router.get("/get-all-categories", verifyJwt, getAllCategories);
router.get("/get-category/:id", verifyJwt, getSingleCategory);
router.delete("/delete-category/:id", verifyJwt, deleteCategory);

export default router;
