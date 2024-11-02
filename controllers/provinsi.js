import pool from "../db/db.js";

export const getAllProvinsi = async (req, res) => {
  const queryText = `SELECT provinsi_id, nama FROM Provinsi`;
  const queryResult = await pool.query(queryText);

  // RESPONSE :
  //   [
  //     {
  //       "provinsi_id": 1,
  //       "nama": "West Java"
  //     },
  //     {
  //       "provinsi_id": 2,
  //       "nama": "East Java"
  //     },
  //     {
  //       "provinsi_id": 3,
  //       "nama": "Central Java"
  //     }
  //   ]
  return res.json(queryResult.rows);
};
