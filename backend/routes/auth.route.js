import express from "express";
import {
  login,
  logout,
  refreshToken,
  register,
} from "../controllers/auth.controller.js";
import verifyJwt from "../utils/vertifyJwt.js";

const router = express.Router();

router.post("/register", register);
router.post("/login", login);
router.post("/logout", verifyJwt, logout);
router.post("/refresh-token", refreshToken);

export default router;
