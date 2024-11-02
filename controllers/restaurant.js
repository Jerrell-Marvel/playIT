import pool from "../db/db.js";
import jwt from "jsonwebtoken";
import bcrypt from "bcryptjs";
import { UnauthorizedError } from "../errors/UnauthorizedError.js";

export const register = async (req, res) => {
  const { nama, email, password, alamat_resmi, kelurahan_id } = req.body;

  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(password, salt);

  const textQuery = `INSERT INTO Restaurant (nama, email, password, alamat_resmi, kelurahan_id) VALUES ($1, $2, $3, $4, $5)`;

  const values = [nama, email, hashedPassword, alamat_resmi, kelurahan_id];

  await pool.query(textQuery, values);

  return res.json("success");
};

export const login = async (req, res) => {
  const { email, password } = req.body;

  if (!email) {
    throw new BadRequestError("Email cannot be empty");
  }

  if (!password) {
    throw new BadRequestError("Password can't be empty");
  }

  const textQuery = `SELECT restaurant_id, nama, email, password, alamat_resmi, kelurahan_id FROM Restaurant WHERE email=$1;`;
  const values = [email];

  const queryResult = await pool.query(textQuery, values);

  const resPassword = queryResult.rows[0].password;
  const restaurantId = queryResult.rows[0].restaurant_id;

  if (!queryResult) {
    throw new UnauthorizedError("Email is not registered");
  }

  //Checking the password
  const isPasswordMatch = await bcrypt.compare(password, resPassword);
  if (!isPasswordMatch) {
    throw new UnauthorizedError("Incorrect password");
  }

  const token = jwt.sign({ restaurantId: restaurantId }, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_LIFETIME,
  });

  return res.json({ success: true, token });
};
