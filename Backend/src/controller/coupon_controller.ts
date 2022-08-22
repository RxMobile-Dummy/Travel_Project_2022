import { CouponDomain } from "../domain/coupon_domain";
import express, { Express, Request, Response } from 'express';
var router = express.Router();

class CouponController {
    static async getAllCoupon(req: Request, res: Response) {
        const couponDomain = new CouponDomain();
        await couponDomain.getAllCoupon(req, res)
    }

    //serch Api
    static async getCouponId(req: Request, res: Response) {
        const couponDomain = new CouponDomain();
        await couponDomain.getCouponId(req, res)
    }

    static async getCoupon(req: Request, res: Response) {
        const couponDomain = new CouponDomain();
        await couponDomain.getCoupon(req, res)
    }
    static async getCouponListMostApplicable(req: Request, res: Response) {
        const couponDomain = new CouponDomain();
        await couponDomain.getCouponListMostApplicable(req, res)
    }
}

router.get('/coupon', CouponController.getAllCoupon);
router.get('/coupon/:id', CouponController.getCouponId);
router.get('/code', CouponController.getCoupon);
router.get('/couponlistmostapplicable', CouponController.getCouponListMostApplicable);
export { router }