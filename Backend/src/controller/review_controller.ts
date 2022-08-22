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

    static async getReviewPending(req: Request, res: Response) {
        const reviewDomain: ReviewDomain = new ReviewDomain();
        await reviewDomain.getReviewPending(req, res);
    }
    static async getReviewApprove(req: Request, res: Response) {
        const reviewDomain: ReviewDomain = new ReviewDomain();
        await reviewDomain.getReviewApprove(req, res);
    }
    static async getReviewImageApprove(req: Request, res: Response) {
        const reviewDomain: ReviewDomain = new ReviewDomain();
        await reviewDomain.getReviewImageApprove(req, res);
    }
}

// POST
router.post("/hotel/:id", ReviewController.postReview);

// GET
router.get("/hotel/:id", ReviewController.getHotelReview);

router.get("/reviewpending/", ReviewController.getReviewPending);
router.get("/reviewapprove/", ReviewController.getReviewApprove);
router.get("/reviewimageapprove/", ReviewController.getReviewImageApprove);

//EXPORT
export { router };