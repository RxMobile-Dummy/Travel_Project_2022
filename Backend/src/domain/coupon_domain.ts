import { citymodel } from "../model/city";
import { StatusCode } from "../statuscode";
import { hotelmodel } from "../model/hotel";
import { couponmodel } from "../model/coupon";
import express, { Express, Request, Response } from 'express'
import { bookingmodel } from "../model/booking";

class CouponDomain {
    async getAllCoupon(req: Request, res: Response) {
        try {
            var today = new Date();
            var couponData = await couponmodel.find({ $and: [{ "startDate": { $lte: today } }, { "endDate": { $gte: today } }] });
            res.status(StatusCode.Sucess).send(couponData);
            res.end();
        }
        catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();
        }
    }


    async getCouponId(req: Request, res: Response) {
        try {
            var today = new Date();
            var couponData = await couponmodel.find({ $and: [{ "_id": req.params.id }, { "startDate": { $lte: today } }, { "endDate": { $gte: today } }] });
            res.status(StatusCode.Sucess).send(couponData);
            res.end();
        }
        catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();
        }
    }

    async getCoupon(req: Request, res: Response) {
        try {
            var today = new Date();
            var q = req.query;
            if (q.price?.length != null && q.code?.length != null) {
                var price: number = Number(q.price);
                var today = new Date();
                var userEligibiltiy;
                if (req.headers['data'] != null) {
                    var reqData = JSON.parse(JSON.stringify(req.headers['data']));
                    var uId = reqData.uid;
                    var bookingData = await bookingmodel.find({ user_id: uId });
                    if (bookingData.length != 0) {
                        userEligibiltiy = "EXISTING";
                    } else {
                        userEligibiltiy = "NEW";
                    }
                } else {
                    userEligibiltiy = "ALL";
                }
                var couponData = await couponmodel.find({
                    $and: [{ "code": q.code }, { "startDate": { $lte: today } }, { "endDate": { $gte: today } }, { "maxOrderValue": { $gte: price } },
                    {
                        $or: [
                            { 'eligibleFor': userEligibiltiy },
                            { 'eligibleFor': 'ALL' }]
                    }]
                });
                if (couponData.length != 0) {
                    res.status(StatusCode.Sucess).send(couponData);
                    res.end();
                } else {
                    var couponData = await couponmodel.find({
                        $and: [{ "code": q.code }, { "startDate": { $lte: today } }, { "endDate": { $gte: today } }, 
                        {
                            $or: [
                                { 'eligibleFor': userEligibiltiy },
                                { 'eligibleFor': 'ALL' }]
                        }]
                    });
                    if(couponData.length!=0){
                       
                        res.status(StatusCode.Sucess).send('This Booking Amount is LOW!!\nSo you can not apply this coupon..\nBetter Luck Next Time!!');
                        res.end();
                    }else{
                        var couponD = await couponmodel.find({
                            $and: [{ "code": q.code }, { "startDate": { $lte: today } }, { "endDate": { $gte: today } },{ "maxOrderValue": { $gte: price } } 
                            ]
                        });
                        if(couponD.length!=0){
                            res.status(StatusCode.Sucess).send('Oh NO!!\n\nSo you can not apply this coupon..\nBetter Luck Next Time!!');
                            res.end();
                        }else{
                            res.status(StatusCode.Sucess).send([]);
                            res.end();
                        }
                        
                    }
                }
            }
        }
        catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();
        }
    }

    async getCouponListMostApplicable(req: Request, res: Response) {
        try {
            var count = 0;
            var couponResult: any = [];
            var q = req.query;
            if (q.price?.length != null) {
                var price: number = Number(q.price);
                var today = new Date();
                var userEligibiltiy;
                if (req.headers['data'] != null) {
                    var reqData = JSON.parse(JSON.stringify(req.headers['data']));
                    var uId = reqData.uid;
                    console.log(uId);
                    var bookingData = await bookingmodel.find({ user_id: uId });
                    if (bookingData.length != 0) {
                        userEligibiltiy = "EXISTING";
                    } else {
                        userEligibiltiy = "NEW";
                    }
                } else {
                    userEligibiltiy = "ALL";
                }
                var couponData = await couponmodel.find({
                    $and: [
                        { "startDate": { $lte: today } },
                        { "endDate": { $gte: today } },
                        { "maxOrderValue": { $gte: price } },
                        {
                            $or: [
                                { 'eligibleFor': userEligibiltiy },
                                { 'eligibleFor': 'ALL' }]
                        }]
                }).sort({ discount: -1 });

                await Promise.all(couponData.map(async (e: any) => {
                    var bookingData = await bookingmodel.find({ coupon_id: e._id });
                    if (bookingData.length == 0) {
                        
                        couponResult.push(e);
                    }
                    if (bookingData.length != 0) {
                        count = 0;
                        bookingData.forEach((c: any) => {
                            if (c.booked_date.getMonth() == today.getMonth()) {
                                count = count + 1;
                            }
                        })
                        if (count < e.noOfUser) {
                            couponResult.push(e);
                        }
                    }
                }))

                couponResult.sort((a: any, b: any) => {
                    return b.discount - a.discount;
                });
                res.status(StatusCode.Sucess).send(couponResult);
                res.end();
            }
        }
        catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();
        }
    }
}

export { CouponDomain };