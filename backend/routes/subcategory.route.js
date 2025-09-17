import express from "express";
import verifyJwt from "../utils/vertifyJwt.js";
import {
  addSubcategory,
  getAllSubcategories,
  getSingleSubcategory,
  getBycategory,
  deleteSubcategory
} from "../controllers/subcategory.controller.js";

const router = express.Router();

router.post("/add-subcategory", verifyJwt, addSubcategory);
router.get("/get-all-subcategories", verifyJwt, getAllSubcategories);
router.get("/get-subcategory/:id", verifyJwt, getSingleSubcategory);
router.get("/get-by-category/:id", verifyJwt, getBycategory);
router.delete("/delete-subcategory/:id", verifyJwt, deleteSubcategory);

export default router;
