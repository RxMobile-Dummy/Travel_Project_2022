import { ReviewDomain } from '../domain/review_domain'
import express, { Express, Request, Response, Router } from 'express';
var router: Router = express.Router();

class ReviewController {
    //Post Review 
    static async postReview(req: Request, res: Response) {
        const reviewDomain: ReviewDomain = new ReviewDomain();
        await reviewDomain.postReview(req, res);
    }

    // Get Hotel Review
    static async getHotelReview(req: Request, res: Response) {
        const reviewDomain: ReviewDomain = new ReviewDomain();
        await reviewDomain.getHotelReview(req, res);
    }

}

// POST
router.post("/hotel/:id", ReviewController.postReview);

// GET
router.get("/hotel/:id", ReviewController.getHotelReview);

//EXPORT
export { router };