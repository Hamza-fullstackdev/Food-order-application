import express from "express";
import {
  deleteUser,
  login,
  adminLogin,
  logout,
  refreshToken,
  register,
} from "../controllers/auth.controller.js";
import verifyJwt from "../utils/vertifyJwt.js";
import upload from "../utils/multer.js";

const router = express.Router();

router.post("/register", upload.single("profileImage"), register);
router.post("/login", login);
router.post("/admin-login", adminLogin);
router.post("/logout", verifyJwt, logout);
router.post("/refresh-token", refreshToken);
router.delete("/delete-user", verifyJwt, deleteUser);

export default router;
