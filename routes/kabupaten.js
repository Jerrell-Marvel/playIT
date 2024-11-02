import express from "express";
import { getKabupatenByProvinsiId } from "../controllers/kabupaten.js";

const router = express.Router();

router.get("/:provinsiId", getKabupatenByProvinsiId);

export default router;
