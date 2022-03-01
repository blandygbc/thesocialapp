import { EntityRepository, getCustomRepository, Repository } from "typeorm";
import { PostEntity } from "../entity/post.entity";
import { Request, Response } from "express";
import { statusCodes } from "../../appConstants";
import { UserRepository } from "./user.repository";
import { StoryEntity } from "../entity/story.entity";

@EntityRepository(StoryEntity)
export class StoryRepository extends Repository<StoryEntity> {
    async storyAdd(req: Request, res: Response) {
        let { useremail } = req.params;
        let { story_assets } = req.body;

        let user = await getCustomRepository(UserRepository).findOne({ useremail });

        await this.insert(this.create({
            story_assets,
            story_user: user!,
        })).then((data: any) => {
            if (data !== undefined) {
                res
                    .status(statusCodes.created)
                    .send({
                        added: true,
                    });
                return true;
            }
        }).catch((error: any) => {
            if (error) {
                console.log(error);
                res
                    .status(statusCodes.badRequest)
                    .send({
                        added: false,
                        message: error
                    });
                return false;
            }
        });
    }

    async storyDelete(req: Request, res: Response) {

        let { story_id } = req.body;

        await this.createQueryBuilder()
            .delete()
            .from("story")
            .where(" story_id = :story_id ", { story_id })
            .execute().then((data: any) => {
                console.log(data);
                let affectedRows = data.affected;
                if (affectedRows > 0) {
                    res
                        .status(statusCodes.ok)
                        .send({
                            deleted: true,
                            message: "Deleted story successfully"
                        });
                    return true;
                } else {
                    res
                        .status(statusCodes.notFound)
                        .send({
                            deleted: false,
                            message: "Couldn't delete story"
                        });
                    return false;
                }
            }).catch((error: any) => {
                if (error) {
                    console.log(error);
                    res
                        .status(statusCodes.badRequest)
                        .send({
                            deleted: false,
                            message: error
                        });
                    return false;
                }
            });

    }

    async storyFindAll(req: Request, res: Response) {
        try {
            let stories = await this.createQueryBuilder("story")
                .leftJoinAndSelect("story.story_user", "users")
                .select()
                .getMany();

            if (stories !== undefined) {
                res
                    .status(statusCodes.ok)
                    .send({
                        received: true,
                        data: stories,
                    });
                return true;
            }
        } catch (error) {
            if (error) {
                console.log(error);
                res
                    .status(statusCodes.badRequest)
                    .send({
                        received: false,
                        message: error,
                        data: null,
                    });
                return false;
            }
        }
    }

    async storyFindAllByUser(req: Request, res: Response) {

        let { useremail } = req.params;
        try {
            let posts = await this.createQueryBuilder("story")
                .leftJoinAndSelect("story.story_user", "users")
                .select()
                .where("story_user.useremail = :useremail", { useremail })
                .getMany();
            if (posts !== undefined) {
                res
                    .status(statusCodes.ok)
                    .send({
                        received: true,
                        data: posts,

                    });
                return true;
            } else {
                res
                    .status(statusCodes.notFound)
                    .send({
                        received: true,
                        data: null,
                        message: "Didn't found any story",
                    });
                return true;
            }
        } catch (error) {
            if (error) {
                console.log(error);
                res
                    .status(statusCodes.badRequest)
                    .send({
                        received: false,
                        data: null,
                        message: "Something went wrong"
                    });
                return false;
            }
        }
    }

    async storyFindOne(req: Request, res: Response) {

        let { story_id } = req.body;
        try {
            let story = await this.createQueryBuilder("story")
                .leftJoinAndSelect("story.story_user", "users")
                .select()
                .where(" story_id = :story_id ",
                    { story_id })
                .getOne();
            if (story !== undefined) {
                res
                    .status(statusCodes.ok)
                    .send({
                        received: true,
                        data: story,

                    });
                return true;
            } else {
                res
                    .status(statusCodes.notFound)
                    .send({
                        received: true,
                        data: null,
                        message: "Didn't found the story",
                    });
                return true;
            }
        } catch (error) {
            if (error) {
                console.log(error);
                res
                    .status(statusCodes.badRequest)
                    .send({
                        received: false,
                        data: null,
                        message: "Something went wrong"
                    });
                return false;
            }
        }
    }
}