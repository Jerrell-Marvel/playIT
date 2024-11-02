import pool from "../db/db.js";
import { NotFoundError } from "../errors/NotFoundError.js";

export const getKecamatanByKabupatenId = async (req, res) => {
  const { kabupatenId } = req.params;
  const queryText = `SELECT kecamatan_id, nama FROM Kecamatan WHERE kabupaten_id = $1`;
  const values = [kabupatenId];

  const queryResult = await pool.query(queryText, values);

  if (queryResult.rowCount === 0) {
    throw new NotFoundError("No Kecamatan Found");
  }

  return res.json(queryResult.rows);
};
