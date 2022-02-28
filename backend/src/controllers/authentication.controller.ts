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
                    message: errMap[0]!['isEmail'].toString()
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
                        message: error
                    })
            }
            //! Saving user data
            let result = await userRepositoy.saveUserData(req, res, hashedPassword);

            //! Sending a JWT
            if (result) {
                AuthenticationController.jwtSign(useremail, statusCodes.created, jwt_secret_key, "1d", req, res);
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
                    message: "Enter a valid email"
                })
        }


        //! DB user data
        let dbUserData = await getCustomRepository(UserRepository)
            .findOne({ where: { useremail: useremail } })

        if (dbUserData !== undefined) {
            console.log("found user")
            //! Compare passwords
            bcrypt.compare(userpassword, dbUserData.userpassword, async (error: any, result: any) => {
                if (error) {
                    console.log(error)
                    return res
                        .status(statusCodes.unauthorized)
                        .send({
                            authentication: false,
                            message: error
                        })
                } else if (!result) {
                    console.log("Wrong user or password")
                    return res
                        .status(statusCodes.forbidden)
                        .send({
                            authentication: false,
                            message: "Wrong user or password"
                        })
                } else {
                    //! Sending a JWT
                    console.log("logged in")
                    return AuthenticationController.jwtSign(useremail, statusCodes.ok, jwt_secret_key, "1d", req, res);
                }
            });
        } else {
            console.log("Wrong user or password")
            return res.status(statusCodes.forbidden)
                .send({
                    message: "Wrong user or password",
                    authenticated: false
                })
        }

    }

    static async jwtSign(
        useremail: string,
        statuscode: number,
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
                        .status(statusCodes.badRequest)
                        .send({
                            authentication: false,
                            message: err
                        })
                }
                console.log("jwtSign send ok")
                return res
                    .status(statuscode)
                    .send({
                        authentication: true,
                        data: data
                    })
            });
    }

    static async decodeJwt(req: Request, res: Response) {
        let token = req.headers.authorization as string;
        let jwt_secret_key = process.env.JWT_SECRET_KEY as string;
        jwt.verify(token, jwt_secret_key, async (error: any, data: any) => {
            if (error) {
                console.log(error)
                return res
                    .status(statusCodes.unauthorized)
                    .send({
                        message: "Something went wrong"
                    })
            } else {
                let useremail = data.useremail!;
                return res
                    .status(statusCodes.ok)
                    .send({
                        data: useremail,
                    })
            }
        });

    }
}