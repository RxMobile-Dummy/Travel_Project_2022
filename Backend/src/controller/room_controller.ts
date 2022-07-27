import { RoomDomain } from '../domain/room_domain'
import express, { Express, Request, Response, Router } from 'express';
var router: Router = express.Router();

class RoomController {

    //get particular room
    static async getPerticularRoom(req: Request, res: Response) {
        const roomDomain = new RoomDomain();
        await roomDomain.getPerticularRoom(req, res);
    }
}

// GET
router.get("/getroom/:hotelid/:roomid", RoomController.getPerticularRoom);

//EXPORT
export { router };