import express from "express";
import { getAllProvinsi } from "../controllers/provinsi.js";

const router = express.Router();

router.get("/", getAllProvinsi);

export default router;
