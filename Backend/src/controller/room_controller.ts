import { RoomDomain } from '../domain/room_domain'
import express, { Express, Request, Response, Router } from 'express';
var Roomrouter : Router = express.Router();
var router: Router = express.Router();


class RoomController {

    // Get Room with Deluxe Type 
    static async getRoomWithDeluxeType(req: Request, res: Response) {

        const roomDomain : RoomDomain = new RoomDomain();
       await roomDomain.getRoomWithDeluxeType(req, res);
        const roomDomain: RoomDomain = new RoomDomain();
        await roomDomain.getRoomWithDeluxeType(req, res);

    }

    // Get Room with Semi-Deluxe Type 
    static async getRoomWithSemiDeluxeType(req: Request, res: Response) {

        const roomDomain : RoomDomain = new RoomDomain();
        await  roomDomain.getRoomWithSemiDeluxeType(req, res);
        const roomDomain: RoomDomain = new RoomDomain();
        await roomDomain.getRoomWithSemiDeluxeType(req, res);

    }

    // Get Room with Super-Deluxe Type 
    static async getRoomWithSuperDeluxeType(req: Request, res: Response) {

        const roomDomain : RoomDomain = new RoomDomain();
        const roomDomain: RoomDomain = new RoomDomain();
        await roomDomain.getRoomWithSuperDeluxeType(req, res);
    }

}

// GET
Roomrouter.get("/:id/deluxe", RoomController.getRoomWithDeluxeType);
Roomrouter.get("/:id/semi-deluxe", RoomController.getRoomWithSemiDeluxeType);
Roomrouter.get("/:id/super-deluxe", RoomController.getRoomWithSuperDeluxeType);

//EXPORT
export { Roomrouter };

router.get("/:id/deluxe", RoomController.getRoomWithDeluxeType);
router.get("/:id/semi-deluxe", RoomController.getRoomWithSemiDeluxeType);
router.get("/:id/super-deluxe", RoomController.getRoomWithSuperDeluxeType);

//EXPORT
export { router };

