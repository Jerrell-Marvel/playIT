import pool from "../db/db.js";
import { BadRequestError } from "../errors/BadRequestError.js";

export const addWaste = async (req, res) => {
  const { restaurantId } = req.user;
  const { food_in_gr } = req.body;

  if (!food_in_gr) {
    throw new BadRequestError("food_in_gr must be included");
  }

  const queryText = `INSERT INTO Waste(date, food_in_gr, restaurant_id) VALUES (CURRENT_DATE, $1, $2)`;
  const values = [food_in_gr, restaurantId];

  await pool.query(queryText, values);

  return res.json({ success: true });
};
