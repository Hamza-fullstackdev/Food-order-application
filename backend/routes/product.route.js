import express from "express";
import verifyJwt from "../utils/vertifyJwt.js";
import {
  addProduct,
  updateProduct,
  addReview,
  deleteProduct,
  getAllProducts,
  getAllProductsByUser,
  getByCategory,
  getBySubCategory,
  getSingleProduct,
  getStatistics
} from "../controllers/product.controller.js";
import upload from "../utils/multer.js";

const router = express.Router();

router.post("/add-product", verifyJwt, upload.single("image"), addProduct);
router.patch(
  "/update-product/:id",
  verifyJwt,
  upload.single("image"),
  updateProduct
);
router.get("/get-statistics", verifyJwt, getStatistics);
router.get("/get-all-products", verifyJwt, getAllProducts);
router.get("/get-product/:id", verifyJwt, getSingleProduct);
router.get("/get-products-by-user", verifyJwt, getAllProductsByUser);
router.get("/get-by-category/:id", verifyJwt, getByCategory);
router.get("/get-by-subcategory/:id", verifyJwt, getBySubCategory);
router.delete("/delete-product/:id", verifyJwt, deleteProduct);
router.post("/add-review", verifyJwt, addReview);

export default router;
