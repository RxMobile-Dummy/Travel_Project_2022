import { TourDomain } from "../domain/tour_domain";
import express, { Express, Request, Response } from 'express';
var router = express.Router();

class TourController {

    //get tour
    static async getTour(req: Request, res: Response) {
        const tourdomain = new TourDomain();
        await tourdomain.getTour(req, res);
    }
}

//get tour based on limit
router.get('/:tourlimit', TourController.getTour);

//export route
export { router };