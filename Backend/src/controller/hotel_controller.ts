import { HotelDomain } from "../domain/hotel_domain";
import express, { Express, Request, Response } from 'express';
var router = express.Router();

class HotelController {
    static async getHotel(req:Request , res : Response){
        const hoteldomain = new HotelDomain();
        hoteldomain.getAllHotel(req,res);
    }

    //hotel image based on request limit
    static async getHotelImage(req:Request , res : Response){
        const hoteldomain = new HotelDomain();
        await hoteldomain.getHotelImage(req,res);
    }
}

router.get('/',HotelController.getHotel);

//get hotel image route
router.get('/image/:imagelimit',HotelController.getHotelImage);
export{router};