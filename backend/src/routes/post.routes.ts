import { Router } from "express";
import { PostController } from "../controllers/post.controller";

const postRouter = Router();

postRouter.get("/", PostController.fetchPosts);
postRouter.post("/add/:useremail", PostController.addPost);


export { postRouter }