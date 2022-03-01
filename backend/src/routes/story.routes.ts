import { Router } from "express";
import { StoryController } from "../controllers/story.controller";

const storyRouter = Router();

//! @GET
storyRouter.get("/", StoryController.storyFindAll);
storyRouter.get("/details/:story_id", StoryController.storyFindOne);
storyRouter.get("/user/:useremail", StoryController.storyFindAllByUser);

//! @POST
storyRouter.post("/add/:useremail", StoryController.storyAdd);

//! @DELETE
storyRouter.delete("/delete/:story_id", StoryController.storyDelete);

export { storyRouter }