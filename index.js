// Express
import express from "express";
const app = express();

// import multer from "multer";
// const upload = multer();
// app.use(upload.array("product-images"));

// Express async errors
import "express-async-errors";

//axios
import axios from "axios";

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
import bahanRoute from "./routes/bahan.js";
import menuRoute from "./routes/menu.js";
import preparationRoute from "./routes/preparation.js";
import wasteRoute from "./routes/waste.js";

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
app.use("/api/bahan", bahanRoute);
app.use("/api/menu", menuRoute);
app.use("/api/preparation", preparationRoute);
app.use("/api/waste", wasteRoute);

// app.get("/test", authMiddleware);

app.get("/test", async (req, res) => {
  // return res.json({ success: true });

  const a = await axios.get("http://192.168.77.50:8080/api/test");
  return res.json(a.data);
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
const HOST = "0.0.0.0";
app.listen(PORT, HOST, async () => {
  try {
    console.log(`Server is running on port ${PORT}`);
  } catch (err) {
    console.log("Failed");
  }
});
