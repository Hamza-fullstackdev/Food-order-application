import express from "express";
import {
  getAllUsers,
  getSingleUser,
  updateUser,
  deleteUser,
} from "../controllers/user.controller.js";
import verifyJwt from "../utils/vertifyJwt.js";
import upload from "../utils/multer.js";

const router = express.Router();

router.get("/get-all-users", verifyJwt, getAllUsers);
router.get("/get-user/:id", verifyJwt, getSingleUser);
router.patch(
  "/update-user/:id",
  verifyJwt,
  upload.single("profileImage"),
  updateUser
);
router.delete("/delete-user/:id", verifyJwt, deleteUser);

export default router;
