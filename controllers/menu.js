import pool from "../db/db.js";
import { BadRequestError } from "../errors/BadRequestError.js";
import { InternalServerError } from "../errors/InternalServerError.js";

export const getAllMenu = async (req, res) => {
  const { restaurantId } = req.user;
  const queryText = `SELECT menu_id, nama, harga FROM Menu WHERE restaurant_id=$1`;

  const queryResult = await pool.query(queryText, [restaurantId]);

  return res.json(queryResult.rows);
};

export const getAllMenuWithIngredients = async (req, res) => {
  const { restaurantId } = req.user;
  const queryText = `
  SELECT 
      m.menu_id,
      m.nama AS menu_name,
      m.harga,
      m.berat,
      b.bahan_id,
      b.nama AS bahan_name,
      bm.kuantitas
  FROM 
      Menu m
  INNER JOIN 
      Bahan_Menu bm ON m.menu_id = bm.menu_id
  INNER JOIN 
      Bahan b ON bm.bahan_id = b.bahan_id
  WHERE 
      m.restaurant_id = $1
`;

  const response = await pool.query(queryText, [restaurantId]);

  // Aggregate results by menu_id
  const menus = response.rows.reduce((acc, row) => {
    const { menu_id, menu_name, harga, berat, bahan_id, bahan_name, kuantitas } = row;

    // Find or create the menu entry
    let menu = acc.find((m) => m.menu_id === menu_id);
    if (!menu) {
      menu = {
        menu_id,
        nama: menu_name,
        harga,
        berat,
        bahan: [],
      };
      acc.push(menu);
    }

    // Add bahan to the current menu's bahan array
    menu.bahan.push({
      bahan_id,
      nama: bahan_name,
      kuantitas,
    });

    return acc;
  }, []);

  console.log(menus);

  return res.json(menus);
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
