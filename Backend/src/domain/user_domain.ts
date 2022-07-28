import { Usermodel } from '../model/users';
import express, { Express, Request, Response } from 'express';
import Joi, { any } from 'joi';
import { StatusCode } from '../statuscode';
import * as admin from 'firebase-admin';


class UserDomain {

    //POST User
    async postUser(req: Request, res: Response) {
        console.log('data')
        try {
            console.log('post');
            let token: any = req.headers['token'];
            var postData: any;
            //verify token
            var decodedToken = await admin.auth().verifyIdToken(token);
            console.log(decodedToken);

            postData = {
                _id: decodedToken.uid,
                user_name: decodedToken.name != null ? decodedToken.name : null,
                user_email: decodedToken.email,
                user_phone_number: decodedToken.phone_number != null ? decodedToken.phone_number : null,
                user_image: decodedToken.picture != null ? decodedToken.picture : null
            }
            var data = new Usermodel(postData);
            console.log(data);
            try {
                await data.save();
                console.log("data addedd");
                res.status(StatusCode.Sucess).send("data added");
                res.end();
            } catch (error: any) {
                if (error.code == 11000) {
                    console.log('errro google')
                    if (decodedToken.firebase.sign_in_provider == "google.com" || decodedToken.firebase.sign_in_provider == "facebook.com") {
                        res.status(StatusCode.Sucess).send("data alerady but google user");
                        res.end();
                    } else {
                        console.log('error duplication')
                        res.status(StatusCode.DuplicationError).send("data is alredy  PRESENT");
                        res.end();
                    }
                } else {
                    console.log('error server')
                    res.status(StatusCode.Server_Error).send(error.message);
                    res.end();
                }
            }
        } catch (e: any) {
            console.log('catch exception')
            res.status(StatusCode.Server_Error).send(e.message);
            res.end();
        }

    }

    //Update User
    async updateUser(req: Request, res: Response) {

        var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
        var uid: string = reqData.uid;

        var joiSchema = Joi.object({
            user_name: Joi.string().min(1).max(30),
            user_phone_number: Joi.string().min(10).max(14),
            user_image: Joi.string()
        });
        var data: object = {
            user_name: req.body.user_name,
            user_phone_number: req.body.user_phone_number,
            user_image: req.body.user_image
        }
        var err: any = joiSchema.validate(data)

        if (err.error) {
            res.status(StatusCode.Server_Error).send(err.error.details[0].message);
        }
        else {
            try {
                await Usermodel.findByIdAndUpdate(uid, data);
                res.status(StatusCode.Sucess).send("data updated");
            }
            catch (err: any) {
                res.status(StatusCode.Server_Error).send(err.message)
            }
        }
    }

    //get user 
    async getUser(req: Request, res: Response) {
        try {
            var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
            var uid: string = reqData.uid;
            console.log(uid);
            var userData = await Usermodel.find({ _id: uid }).select("-__v");
            res.status(StatusCode.Sucess).send(userData);
        } catch (error: any) {
            res.status(StatusCode.Server_Error).send(error.message)
        }
    }

}

//EXPORT
export { UserDomain };