import express, { Express, Request, Response } from 'express';
import { AwsPinpoinntDomain } from '../domain/aws_pinpoint_domain';
var router = express.Router();

class AwsPinpoinntController {
    static async addToWhishList(req: Request, res: Response) {
        const awsPinpoinnDomain = new AwsPinpoinntDomain;
        await awsPinpoinnDomain.addToWhishList(req, res);
    }

    static async madeBooking(req: Request, res: Response) {
        const awsPinpoinnDomain = new AwsPinpoinntDomain;
        await awsPinpoinnDomain.madeBooking(req, res);
    }
}

router.get('/whishlist/:hotelid', AwsPinpoinntController.addToWhishList);
router.get('/booking/:hotelid', AwsPinpoinntController.madeBooking);

export { router };