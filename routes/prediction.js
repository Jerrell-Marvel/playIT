import express from "express";
import { authMiddleware } from "../middleware/authMiddleware.js";
import { prediction, predictionFw } from "../controllers/prediction.js";
const router = express.Router();

router.post("/quantity", authMiddleware, prediction);
router.post("/fw", authMiddleware, predictionFw);

export default router;
