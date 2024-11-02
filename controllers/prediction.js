import axios from "axios";
import { BadRequestError } from "../errors/BadRequestError.js";

export const prediction = async (req, res) => {
  const { restaurantId } = req.user;

  //array of string
  const { menu } = req.body;

  if (!menu) {
    throw new BadRequestError("menu must be included");
  }

  const { data } = await axios.post("http://192.168.77.50:8080/api/predict_quantities", { restaurant_id: restaurantId });

  //   console.log(data);

  const obj = {};
  menu.forEach((m) => {
    const me = m.toLowerCase();
    obj[me] = data.menu[me][0];
  });

  //   console.log(obj);

  return res.json(obj);
};

export const predictionFw = async (req, res) => {
  const { restaurantId } = req.user;

  const bodyData = req.body;

  const obj = {};
  obj.restaurant_id = restaurantId;

  const menuObj = {};
  Object.keys(bodyData).forEach((key) => {
    const val = bodyData[key];

    menuObj[key] = [val];
  });

  obj.menu = menuObj;

  console.log(obj);
  const { data } = await axios.post("http://192.168.77.50:8080/api/predict_fw", obj);

  return res.json({ prediction: data[0] });
};
