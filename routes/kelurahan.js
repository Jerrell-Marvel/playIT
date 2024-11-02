import express from "express";
import { getKelurahanByKecamatanId } from "../controllers/kelurahan.js";

const router = express.Router();

router.get("/:kecamatanId", getKelurahanByKecamatanId);

export default router;
