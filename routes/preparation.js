import express from "express";
import { addPreparation, getPreparationByDate } from "../controllers/preparation.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = express.Router();

router.get("/", authMiddleware, getPreparationByDate);
router.post("/", authMiddleware, addPreparation);

export default router;
