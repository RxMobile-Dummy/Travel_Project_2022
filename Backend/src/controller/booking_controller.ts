import { BookingDomain } from "../domain/booking_domain";
import express, { Express, Request, Response } from 'express';
var router = express.Router();

class BookingController {
    static async addBooking(req: Request, res: Response) {
        const bookIngDomain = new BookingDomain();
        await bookIngDomain.addBooking(req, res);
    }

    static async roomBookAvailableCheck(req: Request, res: Response) {
        const bookIngDomain = new BookingDomain();
        await bookIngDomain.roomBookAvailableCheck(req, res);
    }

    static async userBookingHistory(req: Request, res: Response) {
        const bookIngDomain = new BookingDomain();
        await bookIngDomain.userBookingHistory(req, res);
    }

    static async getRoomBookingPrize(req: Request, res: Response) {
        const bookIngDomain = new BookingDomain();
        await bookIngDomain.getRoomPrize(req, res);
    }
}

router.post('/hotelbooking', BookingController.addBooking);
router.get('/check', BookingController.roomBookAvailableCheck);
router.get('/user/bookings', BookingController.userBookingHistory);
router.get('/roombooking/prize', BookingController.getRoomBookingPrize);
export { router };

