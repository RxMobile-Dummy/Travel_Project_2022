import express, { Express, Request, Response } from 'express';
import { CancelBookingDomain } from '../domain/cancel_booking_domain';
var router = express.Router();

class CancelBookingController{
    static async cancelBooking(req: Request, res: Response) {
        const cancelBookingDomain = new CancelBookingDomain();
        await cancelBookingDomain.cancelBooking(req, res);
    }
}

router.put('/:bookingid/:deviceid', CancelBookingController.cancelBooking);

export { router };