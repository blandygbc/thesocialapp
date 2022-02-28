import { Request, Response } from "express";
import { EntityRepository, Repository } from "typeorm";
import { statusCodes } from "../../appConstants";
import { UserEntity } from "../entity/user.entity";

@EntityRepository(UserEntity)
export class UserRepository extends Repository<UserEntity>{
    async saveUserData(req: Request, res: Response, hashedPassword: any) {
        let { username, useremail, userimage } = req.body;
        /* (await this.createQueryBuilder("users")
            .select()
            .where("users.useremail = :useremail", {
                useremail,
            })
            .getCount()) > 0 */

        let checkIfUserExists = await this.findOne({ where: { useremail: useremail } });
        if (checkIfUserExists !== undefined) {
            console.log("checkIfUserExists send")
            res
                .status(statusCodes.forbidden)
                .send({
                    authenticated: false,
                    message: "User already exists!"
                });
            return false;
        }
        try {
            /* this.createQueryBuilder("users")
                .insert()
                .values({
                    username,
                    useremail,
                    userpassword: hashedPassword
                })
                .execute() */
            await this.insert({
                username,
                useremail,
                userpassword: hashedPassword,
                userimage
            });
            return true;
        } catch (error) {
            console.log(error);
            return false;
        }
    }

    /*     async findUserDataFromEmail(req: Request, res: Response): Promise<any> {
            let { useremail } = req.body;
             await this.createQueryBuilder("users")
                .select("users.userpassword")
                .where("users.useremail = :useremail", {
                    useremail: useremail,
                })
                .getOne() 
            let getBaseUserData = await this.findOne({ where: { useremail: useremail } })
    
            if (getBaseUserData === undefined) {
                console.log("findUserDataFromEmail send forb")
                res.status(statusCodes.forbidden)
                    .send({
                        message: "Wrong user or password",
                        authenticated: false
                    })
                return;
            }
    
            return getBaseUserData;
    
        } */
}