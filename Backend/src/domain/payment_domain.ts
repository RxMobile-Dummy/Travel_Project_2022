import express, { Express, Request, Response } from 'express';

import { Usermodel } from '../model/users';
import * as dotenv from 'dotenv';
dotenv.config();
import { Razorpay } from 'razorpay-typescript';
import * as crypto from "crypto";
import { StatusCode } from '../statuscode';

var secretkey = process.env.KEY_SECRET;
var keyId = process.env.KEY_ID;
const instance: Razorpay = new Razorpay({
    authKey: {
        key_id: keyId ?? "keyId",
        key_secret: secretkey ?? "secretkey"
    },
});
class PaymentDomain {

    async createOrder(req: Request, res: Response) {
        let amount = req.body.amount;
        const options = {
            amount: amount * 100,
            currency: 'INR',
        }
        console.log(options);
        try {
            var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
            var uid: string = reqData.uid;
            var userData = await Usermodel.find({ _id: uid }).select("-__v");
            const response = await instance.orders.create(options);
            var orderData = {
                order_id: response.id,
                currency: response.currency,
                amount: response.amount / 100,
                user_name: userData[0].user_name,
                user_email: userData[0].user_email,
                user_phone_number: userData[0].user_phone_number,
            }
            console.log(orderData);
            res.send(orderData)
        } catch (error: any) {
            res.status(400).send('Unable to create order');
        }



    }


    
}

export { PaymentDomain };