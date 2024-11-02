import express from "express";
import { getKecamatanByKabupatenId } from "../controllers/kecamatan.js";

const router = express.Router();

router.get("/:kabupatenId", getKecamatanByKabupatenId);

export default router;
