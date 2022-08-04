import { HotelDomain } from "../domain/hotel_domain";
import express, { Express, Request, Response } from 'express';
var router = express.Router();

class HotelController {
    static async getHotel(req: Request, res: Response) {
        const hoteldomain = new HotelDomain();
        await hoteldomain.getAllHotel(req, res);
    }

    // get hotel by search
    static async getHotelBySearch(req: Request, res: Response) {
        const hoteldomain = new HotelDomain();
        await hoteldomain.getHotelBySearch(req, res);

    }

    //hotel image based on request limit
    static async getHotelImage(req: Request, res: Response) {
        const hoteldomain = new HotelDomain();
        await hoteldomain.getHotelImage(req, res);
    }
    //hotel image based on request limit
    static async getHotelPerticular(req: Request, res: Response) {
        const hoteldomain = new HotelDomain();
        await hoteldomain.getParticularHotel(req, res);
    }

    //hotel list and filter hotel list api
    static async getHotelFilterList (req:Request , res : Response){
        const hoteldomain = new HotelDomain();
        await hoteldomain.getHotelFilterList(req,res);
    }
}

router.get('/', HotelController.getHotel);

//get hotel image route
router.get('/image/:imagelimit', HotelController.getHotelImage);
router.get('/:hotelsearch', HotelController.getHotelBySearch);
router.get('/gethotel/getsinglehotel/:hotel_id', HotelController.getHotelPerticular);
router.get('/gethotellist/gethotelfilterlist',HotelController.getHotelFilterList);

export { router };