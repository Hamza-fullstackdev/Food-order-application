import express from "express";
import verifyJwt from "../utils/vertifyJwt.js";
import {
  addProduct,
  getAllProducts,
  getAllProductsByUser,
  getSingleProduct,
} from "../controllers/product.controller.js";
import upload from "../utils/multer.js";

const router = express.Router();

router.post("/add-product", verifyJwt, upload.single("image"), addProduct);
router.get("/get-all-products", verifyJwt, getAllProducts);
router.get("/get-product/:id", verifyJwt, getSingleProduct);
router.get("/get-products-by-user", verifyJwt, getAllProductsByUser);
export default router;
