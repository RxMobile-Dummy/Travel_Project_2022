import { Usermodel } from '../model/users';
import express, { Express, Request, Response } from 'express';
import Joi, { any } from 'joi';
import { StatusCode } from '../statuscode';


class UserDomain {

    //POST User
    async postUser(req: Request, res: Response) {
        var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
        var uid: string = reqData.uid;
        var email: string = reqData.email

        var postData: object = {
            _id: uid,
            user_name: req.body.user_name,
            user_email: email,
            user_phone_number: req.body.user_phone_number,
            user_image: req.body.user_image
        }

        var data = new Usermodel(postData);
        try {
            await data.save();
            res.status(StatusCode.Sucess).send("data added");
        }
        catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
        }
        res.end();

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

}

//EXPORT
export { UserDomain };