import { Request, Response } from "express";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import * as EmailValidator from "email-validator";
import bcrypt from "bcrypt";
import { getCustomRepository } from "typeorm";
import { UserRepository } from "../database/repository/user.repository";
import { statusCodes } from "../appConstants";
import { validate } from "class-validator";

dotenv.config()

export class AuthenticationController {
    static async showPosts(req: Request, res: Response) {
        let token = req.headers.authorization as string;
        let jwt_secret_key = process.env.JWT_SECRET_KEY as string;
        jwt.verify(token, jwt_secret_key, async (error: any, data: any) => {
            if (error) {
                return res
                    .status(statusCodes.unauthorized)
                    .send({
                        received: false,
                        data: error
                    })
            }
            return res
                .status(statusCodes.created)
                .send({
                    code: statusCodes.created,
                    posts: "List of posts",
                    userdata: data
                })
        })
    }

    static validateEmail(useremail: string) {
        return EmailValidator.validate(useremail);
    }

    static async signup(req: Request, res: Response) {
        let userRepositoy = getCustomRepository(UserRepository);
        let { useremail, userpassword } = req.body;

        let errMap = await validate(userRepositoy.create({ useremail }), { skipMissingProperties: true /* groups: ['email'] */ })
            .then(errors => {
                return errors.map(v => v.constraints)
            });
        if (undefined !== errMap && errMap.length > 0) {
            return res
                .status(statusCodes.invalidEmail)
                .send({
                    authentication: false,
                    //data: errMap.map(v => v!.isEmail).toString()
                    data: errMap[0]!['isEmail'].toString()
                })
        }

        let jwt_secret_key = process.env.JWT_SECRET_KEY as string;
        let salt = await bcrypt.genSalt(10);
        bcrypt.hash(userpassword, salt, async (error: any, hashedPassword: any) => {
            if (error) {
                console.log("bcrypt send generic")
                return res
                    .status(statusCodes.unauthorized)
                    .send({
                        authentication: false,
                        data: error
                    })
            }
            //! Saving user data
            let result = await userRepositoy.saveUserData(req, res, hashedPassword);

            //! Sending a JWT
            if (result) {
                AuthenticationController.jwtSign(useremail, jwt_secret_key, "1h", req, res);
            }
        });


    }

    static async login(req: Request, res: Response) {
        let { useremail, userpassword } = req.body;

        let jwt_secret_key = process.env.JWT_SECRET_KEY as string;

        if (!AuthenticationController.validateEmail(useremail)) {
            console.log("validateEmail send")
            return res
                .status(statusCodes.invalidEmail)
                .send({
                    authentication: false,
                    data: "Enter a valid email"
                })
        }


        //! DB user data
        let userRepositoy = getCustomRepository(UserRepository);
        let dbUserData = await userRepositoy.findUserDataFromEmail(req, res);

        //! Compare passwords
        bcrypt.compare(userpassword, dbUserData.userpassword, async (error: any, result: any) => {
            if (error) {
                return res
                    .status(statusCodes.unauthorized)
                    .send({
                        authentication: false,
                        data: error
                    })
            }
            if (!result) {
                return res
                    .status(statusCodes.forbidden)
                    .send({
                        authentication: false,
                        data: "Wrong user or password"
                    })
            }
            //! Sending a JWT
            return AuthenticationController.jwtSign(useremail, jwt_secret_key, "1h", req, res);
        });
    }

    static async jwtSign(
        useremail: string,
        secretkey: string,
        expiresIn: string,
        req: Request,
        res: Response
    ) {
        jwt.sign(
            {
                useremail, //! Payload
            },
            secretkey, //! Secret Key
            {
                expiresIn: expiresIn //! Expire Time
            },
            async (err: any, data: any) => {
                //! Callback
                if (err) {
                    console.log("jwtSign send genericErr")
                    return res
                        .status(statusCodes.unauthorized)
                        .send({
                            authentication: false,
                            data: err
                        })
                }
                console.log("jwtSign send ok")
                return res
                    .status(statusCodes.created)
                    .send({
                        authentication: true,
                        data: data
                    })
            });
    }
}