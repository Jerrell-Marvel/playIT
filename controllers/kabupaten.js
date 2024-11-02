import pool from "../db/db.js";
import { NotFoundError } from "../errors/NotFoundError.js";

export const getKabupatenByProvinsiId = async (req, res) => {
  const { provinsiId } = req.params;
  const queryText = `SELECT kabupaten_id, nama FROM Kabupaten WHERE provinsi_id = $1`;
  const values = [provinsiId];

  const queryResult = await pool.query(queryText, values);

  if (queryResult.rowCount === 0) {
    throw new NotFoundError("No Kabupaten Found");
  }

  return res.json(queryResult.rows);
};
