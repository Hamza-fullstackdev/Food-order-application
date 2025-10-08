import express from "express";
import http from "http";
import mongoose from "mongoose";
import cookieParser from "cookie-parser";
import cors from "cors";
import GracefulShutdown from "http-graceful-shutdown";
import { connectToDatabase } from "./config/db.js";
import { config } from "./utils/config.js";
import { rateLimit } from "express-rate-limit";
import helmet from "helmet";
import compression from "compression";
import { startBackup } from "./jobs/run.job.js";

const limiter = rateLimit({
  windowMs: 1000,
  limit: 5,
  message: {
    success: false,
    statusCode: 429,
    message: "Too many requests, please try again later",
  },
});

const app = express();
const server = http.createServer(app);
const PORT = config.PORT || 3000;
connectToDatabase();
startBackup();
app.use(express.json());
app.use(cookieParser());
app.use(limiter);
app.use(helmet());
app.use(
  compression({
    level: 9,
  })
);
app.use(
  cors({
    origin: [
      "http://localhost:3000",
      "https://food-order-application-rust.vercel.app",
    ],
    methods: ["GET", "POST", "PATCH", "DELETE"],
    credentials: true,
  })
);

import authRouter from "./routes/auth.route.js";
import userRouter from "./routes/user.route.js";
import productRouter from "./routes/product.route.js";
import categoryRouter from "./routes/category.route.js";
import subCategoryRouter from "./routes/subcategory.route.js";
import cartRouter from "./routes/cart.route.js";
import orderRouter from "./routes/order.route.js";

app.use("/api/v1/auth", authRouter);
app.use("/api/v1/user", userRouter);
app.use("/api/v1/product", productRouter);
app.use("/api/v1/category", categoryRouter);
app.use("/api/v1/subcategory", subCategoryRouter);
app.use("/api/v1/cart", cartRouter);
app.use("/api/v1/order", orderRouter);

server.listen(PORT || 5000, () => {
  console.log(`Server is running on port ${PORT || 5000}`);
});

GracefulShutdown(server, {
  signals: "SIGINT SIGTERM",
  timeout: 10000,
  onShutdown: async () => {
    console.log("Gracefully shutting down server...");
    if (mongoose.connection.readyState === 1) {
      await mongoose.connection.close();
      console.log("MongoDB connection closed.");
    }
  },
  finally: () => {
    console.log("Server completely stopped.");
  },
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
