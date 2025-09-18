import express from "express";
import {
  addToCart,
  getCart,
  removeFromCart,
  updateCart,
} from "../controllers/cart.controller.js";
import verifyJwt from "../utils/vertifyJwt.js";

const router = express.Router();

router.post("/add-to-cart", verifyJwt, addToCart);
router.patch("/update-cart/:id", verifyJwt, updateCart);
router.get("/get-cart", verifyJwt, getCart);
router.delete("/remove-from-cart/:id", verifyJwt, removeFromCart);

export default router;
