import express from "express";
import { register, login } from "../controllers/restaurant.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = express.Router();

router.post("/register", register);
router.post("/login", login);
router.get("/testing", authMiddleware, (req, res) => res.json("yes"));

export default router;
