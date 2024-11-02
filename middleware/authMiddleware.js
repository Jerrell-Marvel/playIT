import { UnauthorizedError } from "../errors/UnauthorizedError.js";
import jwt from "jsonwebtoken";

export const authMiddleware = (req, res, next) => {
  const { token } = req.cookies;
  console.log(token);
  if (!token) {
    throw new UnauthorizedError("token not provided");
  }

  try {
    const payload = jwt.verify(token, process.env.JWT_SECRET);
    req.user = {
      restaurantId: payload.restaurantId,
    };

    console.log(req.user);
    next();
  } catch (err) {
    throw new UnauthorizedError("invalid token");
  }
};
