import express from "express";
// import { config } from "./utils/config.js";
import cookieParser from "cookie-parser";
import cors from "cors";
import { connectToDatabase } from "./utils/db.js";

const app = express();
// const PORT = config.PORT || 3000;
connectToDatabase();

app.use(express.json());
app.use(cookieParser());
app.use(
  cors({
    origin: "http://localhost:3000",
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

app.use("/api/v1/auth", authRouter);
app.use("/api/v1/user", userRouter);
app.use("/api/v1/product", productRouter);
app.use("/api/v1/category", categoryRouter);
app.use("/api/v1/subcategory", subCategoryRouter);
app.use("/api/v1/cart", cartRouter);

// app.listen(process.env.PORT || 3000, () => {
//   console.log(`Server is running on port ${process.env.PORT || 3000}`);
// });

app.use((err, req, res, next) => {
  const statusCode = err.statusCode || 500;
  const message = err.message || "Internal Server error";
  res.status(statusCode).send({
    success: false,
    statusCode,
    message,
  });
});

export default app;