import pool from "../db/db.js";
import { BadRequestError } from "../errors/BadRequestError.js";

export const getAllBahan = async (req, res) => {
  const { restaurantId } = req.user;
  const queryText = `SELECT bahan_id, nama from BAHAN WHERE restaurant_id = $1`;

  const queryResult = await pool.query(queryText, [restaurantId]);

  return res.json(queryResult.rows);
};

export const addBahan = async (req, res) => {
  const { nama } = req.body;
  const { restaurantId } = req.user;

  if (!nama) {
    throw new BadRequestError("no name included");
  }

  const queryText = `INSERT INTO Bahan (nama, restaurant_id) VALUES ($1, $2) RETURNING bahan_id;`;
  const values = [nama, restaurantId];

  const queryResult = await pool.query(queryText, values);
  const bahanId = queryResult.rows[0].bahan_id;

  return res.json({ bahan_id: bahanId });
};
