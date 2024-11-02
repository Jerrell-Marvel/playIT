import pool from "../db/db.js";
import { BadRequestError } from "../errors/BadRequestError.js";
import { InternalServerError } from "../errors/InternalServerError.js";

export const getAllMenu = async (req, res) => {
  const { restaurantId } = req.user;
  const queryText = `SELECT menu_id, nama, harga FROM Menu WHERE restaurant_id=$1`;

  const queryResult = await pool.query(queryText, [restaurantId]);

  return res.json(queryResult.rows);
};

export const addMenu = async (req, res) => {
  const { nama, harga, berat, bahan } = req.body;
  const { restaurantId } = req.user;

  if (!nama || !harga || !bahan || !berat) {
    throw new BadRequestError("nama, harga, bahan, berat must be included");
  }

  const client = await pool.connect();
  let menuId;
  try {
    await client.query("BEGIN");

    const queryResultMenu = await client.query("INSERT INTO Menu (nama, harga, berat, restaurant_id) VALUES ($1, $2, $3, $4) RETURNING menu_id", [nama, harga, berat, restaurantId]);
    menuId = queryResultMenu.rows[0].menu_id;

    // insert bahannya
    const bahanValues = [];
    let ctr = 0;
    const placeholders = bahan
      .map((e, i) => {
        bahanValues.push(menuId, e.bahan_id, e.kuantitas);
        return `($${++ctr}, $${++ctr}, $${++ctr})`;
      })
      .join(", ");

    const queryTextBahan = `INSERT INTO Bahan_Menu (menu_id, bahan_id, kuantitas) VALUES ${placeholders};`;

    await client.query(queryTextBahan, bahanValues);

    await client.query("COMMIT");
    return res.json({ menu_id: menuId });
  } catch (error) {
    console.log(error);
    await client.query("ROLLBACK");
    throw new InternalServerError("An unexpected error occurred");
  } finally {
    client.release();
  }
};
