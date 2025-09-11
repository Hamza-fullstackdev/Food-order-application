import express from "express";
import { config } from "./utils/config.js";
import cookieParser from "cookie-parser";
import cors from "cors";
import { connectToDatabase } from "./utils/db.js";

const app = express();
const PORT = config.PORT || 3000;
connectToDatabase();

app.use(express.json());
app.use(cookieParser());
app.use(cors());

import authRouter from "./routes/auth.route.js";

app.use("/api/auth/v1", authRouter);

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

app.use((err, req, res, next) => {
  const statusCode = err.statusCode || 500;
  const message = err.message || "Internal Server error";
  res.status(statusCode).send({
    success: false,
    statusCode,
    message,
  });
});