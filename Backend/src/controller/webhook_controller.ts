import express, { Express, Request, Response } from 'express';
import { WebhookDomain } from '../domain/webhook_domain';
var router = express.Router();

class WebhookController {
    static async verifyPayment(req: Request, res: Response) {
        const webhookDomain = new WebhookDomain();
        await webhookDomain.verifyPayment(req, res);
    }
}

router.post('/verifypayment', WebhookController.verifyPayment);
export { router }