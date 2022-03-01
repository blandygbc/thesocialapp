import express from "express";
import { createConnection } from "typeorm";
import { authRouter } from "./routes/authentication.routes";
import config from "./ormconfig";
import "reflect-metadata";
import { postRouter } from "./routes/post.routes";
import { storyRouter } from "./routes/story.routes";

const app = express();
const port = process.env.PORT || 8080;

createConnection(config).then(async (connection) => {
    console.log(`🐘 is connectecd!`);
    app.set("port", port);
    app.use(express.json());
    app.use(express.urlencoded({ extended: false }));

    app.get("/", (req, res) => {
        res.send({ data: "TheSociaApp Rebuild API" });
    })

    //! Authentication route
    app.use("/user", authRouter)

    //! Posts Route
    app.use("/post", postRouter)

    //! Story Route
    app.use("/story", storyRouter)

    app.listen(app.get("port"), () => {
        console.log(`Server is 🏃 at port ${app.get("port")}`);
    })
})
