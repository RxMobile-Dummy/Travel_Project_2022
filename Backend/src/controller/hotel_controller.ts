import { HotelDomain } from "../domain/hotel_domain";
import express, { Express, Request, Response } from 'express';
var router = express.Router();

class HotelController {
    static async getHotel(req:Request , res : Response){
        const hotelDomain = new HotelDomain(); 
       await hotelDomain.getAllHotel(req,res);

    }
    // get hotel by search
    static async getHotelBySearch(req:Request , res : Response){
        const hotelDomain = new HotelDomain();
       await hotelDomain.getHotelBySearch(req,res);

    }

    // get hot by city and room
    static async getHotelBycityroom(req:Request , res : Response){
        const hotelDomain = new HotelDomain();
       await hotelDomain.getHotelByCityRoom(req,res);

    }
}

router.get('/',HotelController.getHotel);
router.get('/:hotelsearch',HotelController.getHotelBySearch);
router.get('/:cityname/:roomcount',HotelController.getHotelBycityroom);
export{router};