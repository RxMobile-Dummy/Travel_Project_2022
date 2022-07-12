import { HotelDomain } from "../domain/hotel_domain";
import express, { Express, Request, Response } from 'express';
var router = express.Router();

class HotelController {
    static async getHotel(req:Request , res : Response){
        const hoteldomain = new HotelDomain();
        await hoteldomain.getAllHotel(req,res);
    }
    // get hotel by search
    static async getHotelBySearch(req:Request , res : Response){
        const hoteldomain = new HotelDomain();
       await hoteldomain.getHotelBySearch(req,res);
    }
}

router.get('/',HotelController.getHotel);
router.get('/:hotelsearch',HotelController.getHotelBySearch);
export{router};