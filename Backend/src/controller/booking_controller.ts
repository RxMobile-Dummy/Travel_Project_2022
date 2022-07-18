import { BookingDomain } from "../domain/booking_domain";
import express, { Express, Request, Response } from 'express';
var router = express.Router();

class BookingController {
    static async addBooking(req : Request , res : Response){
        const bookIngDomain = new BookingDomain();
        await bookIngDomain.addBooking(req,res);
    }
}

router.post('/hotelbooking' , BookingController.addBooking);
export{router};

