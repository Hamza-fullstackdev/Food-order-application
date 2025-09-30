import express from "express";
import verifyJwt from "../utils/vertifyJwt.js";
import { createOrder } from "../controllers/order.controller.js";

const router = express.Router();

router.post("/create-order", verifyJwt, createOrder);

export default router;
