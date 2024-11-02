import pool from "../db/db.js";
import { NotFoundError } from "../errors/NotFoundError.js";

export const getKelurahanByKecamatanId = async (req, res) => {
  const { kecamatanId } = req.params;
  const queryText = `SELECT kelurahan_id, nama FROM Kelurahan WHERE kecamatan_id = $1`;
  const values = [kecamatanId];

  const queryResult = await pool.query(queryText, values);

  if (queryResult.rowCount === 0) {
    throw new NotFoundError("No kelurahan Found");
  }

  return res.json(queryResult.rows);
};
