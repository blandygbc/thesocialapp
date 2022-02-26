import { Router } from "express";
import { AuthenticationController } from "../controllers/authentication.controller";

const authRouter = Router();

authRouter.get("/", (req, res) => { res.send("Authentication routes") });
authRouter.post("/signup", AuthenticationController.signup);
authRouter.post("/login", AuthenticationController.login);
authRouter.get("/posts", AuthenticationController.showPosts);

export { authRouter }