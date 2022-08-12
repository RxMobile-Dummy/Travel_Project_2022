import { PaymentDomain } from "../domain/payment_domain";
import express, { Express, Request, Response } from 'express';
var router = express.Router();

class PaymentController {

    static async createOrder(req: Request, res: Response) {
        const paymentDomain = new PaymentDomain();
        await paymentDomain.createOrder(req, res);
    }


}


router.post("/", PaymentController.createOrder);

export { router };