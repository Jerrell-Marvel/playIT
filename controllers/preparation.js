import pool from "../db/db.js";
import { BadRequestError } from "../errors/BadRequestError.js";
import { InternalServerError } from "../errors/InternalServerError.js";

export const getPreparationByDate = async (req, res) => {
  const { restaurantId } = req.user;

  const { date } = req.query;
  if (!date) {
    throw new BadRequestError("date must be included");
  }

  const queryText = `SELECT Preparation.date, Preparation_Item.porsi, Menu.nama as nama, Menu.harga FROM Preparation JOIN Preparation_Item ON Preparation.preparation_id = Preparation_Item.preparation_id JOIN Menu ON Preparation_Item.menu_id = Menu.menu_id WHERE Preparation.restaurant_id = $1 AND Preparation.date = $2`;

  const queryResult = await pool.query(queryText, [restaurantId, date]);

  const queryWaste = `SELECT food_in_gr FROM Waste WHERE date = $1`;
  const wasteResult = await pool.query(queryWaste, [date]);
  return res.json({
    menu: queryResult.rows,
    waste: wasteResult.rows[0]?.food_in_gr || null,
  });
};

export const addPreparation = async (req, res) => {
  const { menu } = req.body;
  const { restaurantId } = req.user;

  if (!menu) {
    throw new BadRequestError("menu must be included");
  }

  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    const preparationQueryResult = await client.query(`INSERT INTO PREPARATION (date, restaurant_id) VALUES (CURRENT_DATE, $1) RETURNING preparation_id`, [restaurantId]);
    const preparationId = preparationQueryResult.rows[0].preparation_id;

    let ctr = 0;
    const values = [];
    const placeholders = menu
      .map((e, i) => {
        values.push(preparationId, e.menu_id, e.porsi);
        return `($${++ctr}, $${++ctr}, $${++ctr})`;
      })
      .join(", ");

    const preparationItemTextQuery = `INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES ${placeholders};`;

    console.log(preparationItemTextQuery);
    console.log(values);

    await client.query(preparationItemTextQuery, values);

    await client.query("COMMIT");

    return res.json({ preparation_id: preparationId });
  } catch (error) {
    console.log(error);
    await client.query("ROLLBACK");

    throw new InternalServerError("An unexpected error occurred");
  } finally {
    client.release();
  }
};
