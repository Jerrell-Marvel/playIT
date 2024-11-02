import express from "express";
import { getAllBahan, addBahan } from "../controllers/bahan.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = express.Router();

router.get("/", authMiddleware, getAllBahan);
router.post("/", authMiddleware, addBahan);

export default router;
