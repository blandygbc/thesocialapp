import { EntityRepository, getCustomRepository, Repository } from "typeorm";
import { PostEntity } from "../entity/post.entity";
import { Request, Response } from "express";
import { statusCodes } from "../../appConstants";
import { UserRepository } from "./user.repository";

@EntityRepository(PostEntity)
export class PostRepository extends Repository<PostEntity> {
    async addPost(req: Request, res: Response) {
        let { useremail } = req.params;
        let { post_title, post_text, post_images, post_comments, post_likes } = req.body;

        let user = await getCustomRepository(UserRepository).findOne({ useremail });

        await this.insert(this.create({
            post_title,
            post_text,
            post_images,
            post_comments,
            post_likes,
            post_user: user!,
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

    async fetchPosts(req: Request, res: Response) {
        try {
            /* let posts = await this.find({
                                where: {
                                    users: {
                                        user_id: "post.post_user"
                                    }
                                }, 
                relations: ['users'],
            }) */
            let posts = await this.createQueryBuilder("post")
                .leftJoinAndSelect("post.post_user", "users")
                .select()
                .getMany();

            if (posts !== undefined) {
                res
                    .status(statusCodes.ok)
                    .send({
                        received: true,
                        data: posts,

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

    /*     async findUserPosts(req: Request, res: Response) {
    
            let { useremail } = req.params;
            let user = await getCustomRepository(UserRepository).findOne({ useremail });
            try {
                let post = await this.find({
                    where: {
                        users: { user_id: user },
                    },
                    relations: ["users"],
                });
                if (post !== undefined) {
                    res
                        .status(statusCodes.ok)
                        .send({
                            received: true,
                            data: post,
    
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
                        });
                    return false;
                }
            }
        } */
}