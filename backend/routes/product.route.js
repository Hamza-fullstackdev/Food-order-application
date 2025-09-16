import express from "express";
import verifyJwt from "../utils/vertifyJwt.js";
import { addProduct } from "../controllers/product.controller.js";
import upload from "../utils/multer.js";

const router = express.Router();

router.post("/add-product",verifyJwt, upload.single("image"), addProduct);

export default router;
