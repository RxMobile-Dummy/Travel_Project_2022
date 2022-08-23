import express, { Express, Request, Response } from 'express';
import { reviewmodel } from '../model/review';
import { Usermodel } from '../model/users';
import { StatusCode } from '../statuscode';
import { hotelmodel } from "../model/hotel";

class ReviewDomain {

    //POST Review
    async postReview(req: Request, res: Response) {

        var nextID: any = await reviewmodel.findOne({}, { _id: 1 }).sort({ _id: -1 });
        var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));

        var checkUserPostedReview = await reviewmodel.find({ user_id: reqData.uid })
        if (checkUserPostedReview.length != 0) {
            res.status(StatusCode.Sucess).send('review alerady posted')
            res.end();
        } else {
            var rating: Number = (Number(req.body.cleanliness) + Number(req.body.comfort) + Number(req.body.location) + Number(req.body.facilities)) / 4;
            var hotelId: Number = parseInt(req.params.id);
            var imageDataStore: any = [];
            var count = 1;
            req.body.imageUrl.forEach((e: any) => {
                imageDataStore.push({
                    "image_id": count,
                    "image_url": e,
                });
                count++;
            })
            var postData: object = {
                _id: nextID?._id == undefined ? 1 : Number(nextID?.id) + 1,
                user_id: reqData.uid,
                hotel_id: hotelId,
                date: Date.now(),
                comment: req.body.comment,
                cleanliness: req.body.cleanliness.toFixed(1),
                comfort: req.body.comfort.toFixed(1),
                location: req.body.location.toFixed(1),
                facilities: req.body.facilities.toFixed(1),
                rating: rating,
                status: 'pending',
                image: imageDataStore
            }
            console.log(postData);
            var data = new reviewmodel(postData);
            try {

                var cleanliness = 0.0;
                var comfort = 0.0;
                var location = 0.0;
                var facilities = 0.0;

                await data.save();
                var hotelReview = await reviewmodel.find({ hotel_id: req.params.id }).populate({ path: 'user_id', model: Usermodel, select: { 'user_name': 1, 'user_image': 1, '_id': 0 } });
                if (hotelReview.length == 0) {
                    res.status(StatusCode.Not_Found).send({});
                }
                else {
                    hotelReview.forEach((e: any) => {
                        cleanliness = cleanliness + e.cleanliness;
                        comfort = comfort + e.comfort;
                        location = location + e.location;
                        facilities = facilities + e.facilities;
                    })
                    var avgCleanliness = cleanliness / hotelReview.length;
                    var avgComfort = comfort / hotelReview.length;
                    var avgLocation = location / hotelReview.length;
                    var avgFacilities = facilities / hotelReview.length;

                    var avgRating = ((avgCleanliness + avgComfort + avgLocation + avgFacilities) / 4).toExponential(1);
                    await hotelmodel.updateOne({ _id: hotelId }, { $set: { rating: avgRating } });
                    console.log("updated");
                    res.status(StatusCode.Sucess).send({});
                }
            }

            catch (err: any) {
                res.status(StatusCode.Server_Error).send(err.message);
            }
            res.end();
        }
    }


    // GET Hotel Review
    async getHotelReview(req: Request, res: Response) {
        try {
            var cleanliness = 0;
            var comfort = 0;
            var location = 0;
            var facilities = 0;
            var hotelReview = await reviewmodel.find({ hotel_id: req.params.id }, { __v: 0 }).populate({ path: 'user_id', model: Usermodel, select: { 'user_name': 1, 'user_image': 1, '_id': 0 } });
            var resHotel = await hotelmodel.find({ "_id": req.params.id });
            if (hotelReview.length == 0 && resHotel.length == 0) {
                res.status(StatusCode.Sucess).send([]);
            }
            else {
                if (hotelReview.length == 0) {
                    var resData = {
                        hotel_id: resHotel[0]._id,
                        hotelRating: resHotel[0].rating,
                        avgCleanliness: 0.0,
                        avgComfort: 0.0,
                        avgLocation: 0.0,
                        avgFacilities: 0.0,
                        reviews: []
                    }
                    console.log(resData);
                    res.status(StatusCode.Sucess).send(resData);
                    res.end();
                } else {

                    hotelReview.forEach((e: any) => {
                        cleanliness = cleanliness + e.cleanliness;
                        comfort = comfort + e.comfort;
                        location = location + e.location;
                        facilities = facilities + e.facilities;
                    })
                    var avgCleanliness = cleanliness / hotelReview.length;
                    var avgComfort = comfort / hotelReview.length;
                    var avgLocation = location / hotelReview.length;
                    var avgFacilities = facilities / hotelReview.length;
                    var resD = {
                        hotel_id: resHotel[0]._id,
                        hotelRating: resHotel[0].rating,
                        avgCleanliness: avgCleanliness,
                        avgComfort: avgComfort,
                        avgLocation: avgLocation,
                        avgFacilities: avgFacilities,
                        reviews: hotelReview
                    }
                    console.log(resD);
                    res.status(StatusCode.Sucess).send(resD);
                    res.end();
                }
            }
        }
        catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
        }
        res.end();
    }

    async getReviewPending(req: Request, res: Response) {
        try {
            var resReview = await reviewmodel.find({ "status": 'pending' }).populate({ path: 'user_id', model: Usermodel, select: { 'user_name': 1, 'user_image': 1, '_id': 0 } }).populate({ path: 'hotel_id', model: hotelmodel, select: { 'hotel_name': 1, '_id': 1 } }).sort({ date: 1 }).select({ "status": 0 })
            res.status(StatusCode.Sucess).send(resReview);
            res.end();
        } catch (error: any) {
            res.status(StatusCode.Server_Error).send(error.message);
            res.end();
        }
    }

    async getReviewApprove(req: Request, res: Response) {

        var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
        var uid: string = reqData.uid;
        // var uid: string = "dwkkf5q7ufOeZCSqo5qMBR1sA1F2";
        var userData = await Usermodel.find({ _id: uid }).select("-__v");
        if (reqData.admin == true) {
            var q: any = req.query;
            if (q.approve.length != null) {
                var flag: boolean = q.approve == 'true' ? true : false;
                console.log(flag)

                if (flag == true) {

                    var ratingData = await reviewmodel.updateOne({ _id: q.review_id }, {
                        $set: {
                            status: "approve"
                        }
                    })
                    // var resReview = await reviewmodel.find({ "status": 'pending' }).populate({ path: 'user_id', model: Usermodel, select: { 'user_name': 1, 'user_image': 1, '_id': 0 } }).populate({ path: 'hotel_id', model: hotelmodel, select: { 'hotel_name': 1, '_id': 1 } }).sort({ date: 1 }).select({ "status": 0 })
                    res.status(StatusCode.Sucess).send("Review Approved");
                    res.end();
                } else if (flag == false) {

                    var reviewData = await reviewmodel.find({ _id: q.review_id });
                    if (reviewData) {
                        await reviewmodel.deleteOne({ _id: q.review_id });
                        // var resReview = await reviewmodel.find({ "status": 'pending' }).populate({ path: 'user_id', model: Usermodel, select: { 'user_name': 1, 'user_image': 1, '_id': 0 } }).populate({ path: 'hotel_id', model: hotelmodel, select: { 'hotel_name': 1, '_id': 1 } }).sort({ date: 1 }).select({ "status": 0 })
                        res.status(StatusCode.Sucess).send("Review Rejected");
                        res.end();
                    }
                }
            }

        } else {
            res.status(StatusCode.Unauthorized).send("you are not authorize");
            res.end();
        }
    }

    async getReviewImageApprove(req: Request, res: Response) {
        try {

            var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
            var uid: string = reqData.uid;
            // var uid: string = "dwkkf5q7ufOeZCSqo5qMBR1sA1F2";
            var userData = await Usermodel.find({ _id: uid }).select("-__v");
            if (reqData.admin == true) {
                var q: any = req.query;
                if (q.image_id.length != null && q.review_id != null) {
                    var resReviewData = await reviewmodel.find({ _id: parseInt(q.review_id) });
                    if (resReviewData) {
                        var imageData = resReviewData[0].image;
                        var imageDataDeleted: any = [];

                        imageData.forEach((e: any) => {
                            if (e.image_id != q.image_id) {
                                imageDataDeleted.push(e);
                            }
                        })
                        await reviewmodel.updateOne({ _id: q.review_id }, { $set: { image: imageDataDeleted } });
                        // var resReview = await reviewmodel.find({ "status": 'pending' }).populate({ path: 'user_id', model: Usermodel, select: { 'user_name': 1, 'user_image': 1, '_id': 0 } }).populate({ path: 'hotel_id', model: hotelmodel, select: { 'hotel_name': 1, '_id': 1 } }).sort({ date: 1 }).select({ "status": 0 })
                        res.status(StatusCode.Sucess).send("Image Deleted Success");
                        res.end();
                    }
                }
            }
        } catch (error: any) {
            res.status(StatusCode.Server_Error).send(error.message);
            res.end();
        }
    }




}

//EXPORT
export { ReviewDomain };