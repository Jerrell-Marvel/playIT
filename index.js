// Express
import express from "express";
const app = express();

// import multer from "multer";
// const upload = multer();
// app.use(upload.array("product-images"));

// Express async errors
import "express-async-errors";

// Error handler
import { errorHandler } from "./middleware/errorHandler.js";

//Path
import path from "path";

// dotenv
import dotenv from "dotenv";
dotenv.config();

// Cors
import cors from "cors";

// Model import (Use .js file extension!!!)
import cookieParser from "cookie-parser";

// Routes import
import restaurantRoute from "./routes/restaurant.js";
import provinsiRoute from "./routes/provinsi.js";
import kabupatenRoute from "./routes/kabupaten.js";
import kecamatanRoute from "./routes/kecamatan.js";
import kelurahanRoute from "./routes/kelurahan.js";
// import productsRoutes from "./routes/product.js";
// import cartRoutes from "./routes/cart.js";

// Cookie parse
app.use(cookieParser());

// Parse json
app.use(express.json());

//Setting up cors
app.use(cors());

// Routes
app.use("/api", restaurantRoute);
app.use("/api/provinsi", provinsiRoute);
app.use("/api/kabupaten", kabupatenRoute);
app.use("/api/kecamatan", kecamatanRoute);
app.use("/api/kelurahan", kelurahanRoute);

// app.get("/test", authMiddleware);

// pool
import pool from "./db/db.js";
import { InternalServerError } from "./errors/InternalServerError.js";

app.get("/test", async (req, res) => {
  return res.json({ success: true });
  try {
    const a = await pool.query("SELECT 5+5;");
    console.log(a);
    return res.json(a.rows);
  } catch (err) {
    throw new InternalServerError("error");
  }
});

//Error handling
app.use(errorHandler);

// Run the server
const PORT = 5000;
app.listen(PORT, async () => {
  try {
    console.log(`Server is running on port ${PORT}`);
  } catch (err) {
    console.log("Failed");
  }
});
