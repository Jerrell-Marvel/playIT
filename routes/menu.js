import express from "express";
import { addMenu, getAllMenu } from "../controllers/menu.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = express.Router();

router.get("/", authMiddleware, getAllMenu);
router.post("/", authMiddleware, addMenu);

export default router;
