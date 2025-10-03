import express from "express";
import verifyJwt from "../utils/vertifyJwt.js";
import {
  createOrder,
  getAllOrders,
  getSingleOrder,
  updateOrder,
} from "../controllers/order.controller.js";

const router = express.Router();

router.post("/create-order", verifyJwt, createOrder);
router.get("/get-all-orders", verifyJwt, getAllOrders);
router.get("/get-order/:id", verifyJwt, getSingleOrder);
router.patch("/update-order/:id", verifyJwt, updateOrder);

export default router;
