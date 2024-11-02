import express from "express";
import { authMiddleware } from "../middleware/authMiddleware.js";
import { addWaste } from "../controllers/waste.js";

const router = express.Router();

router.post("/", authMiddleware, addWaste);

export default router;
