import { BookingDomain } from "../domain/booking_domain";
import express, { Express, Request, Response } from 'express';
var router = express.Router();

class BookingController {
    static async addBooking(req : Request , res : Response){
        const bookIngDomain = new BookingDomain();
        await bookIngDomain.addBooking(req,res);
    }

    static async roomBookAvailableCheck(req : Request , res : Response){
        const bookIngDomain = new BookingDomain();
        await bookIngDomain.roomBookAvailableCheck(req,res);
    }

    static async userBookingHistory(req : Request , res : Response){
        const bookIngDomain = new BookingDomain();
        await bookIngDomain.userBookingHistory(req,res);
    }
}

router.post('/hotelbooking' , BookingController.addBooking);
router.get('/check' , BookingController.roomBookAvailableCheck);
router.get('/user/history' , BookingController.userBookingHistory);
export{router};

