import { HotelDomain } from "../domain/hotel_domain";
import express, { Express, Request, Response } from 'express';
var router = express.Router();

class HotelController {
    static async getHotel(req:Request , res : Response){
        const hoteldomain = new HotelDomain();
        hoteldomain.getAllHotel(req,res);
    }
}

router.get('/',HotelController.getHotel);
export{router};