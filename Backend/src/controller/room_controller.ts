import { RoomDomain } from '../domain/room_domain'
import express, { Express, Request, Response } from 'express';
var Roomrouter = express.Router();

class RoomController {

    // Get Room with Deluxe Type 
    static async getRoomWithDeluxeType(req: Request, res: Response) {
        const roomDomain = new RoomDomain();
        roomDomain.getRoomWithDeluxeType(req, res);
    }

    // Get Room with Semi-Deluxe Type 
    static async getRoomWithSemiDeluxeType(req: Request, res: Response) {
        const roomDomain = new RoomDomain();
        roomDomain.getRoomWithSemiDeluxeType(req, res);
    }

    // Get Room with Super-Deluxe Type 
    static async getRoomWithSuperDeluxeType(req: Request, res: Response) {
        const roomDomain = new RoomDomain();
        roomDomain.getRoomWithSuperDeluxeType(req, res);
    }

}

// GET
Roomrouter.get("/:id/deluxe", RoomController.getRoomWithDeluxeType);
Roomrouter.get("/:id/semi-deluxe", RoomController.getRoomWithSemiDeluxeType);
Roomrouter.get("/:id/super-deluxe", RoomController.getRoomWithSuperDeluxeType);

//EXPORT
export { Roomrouter };