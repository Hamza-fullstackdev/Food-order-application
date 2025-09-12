import express from "express";
import { login, logout, register } from "../controllers/auth.controller.js";
import verifyJwt from "../utils/vertifyJwt.js";

const router = express.Router();

router.post("/register", register);
router.post("/login", login);
router.post("/logout", verifyJwt, logout);

export default router;
