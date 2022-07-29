import express, { Express, Request, Response } from 'express';
import { reviewmodel } from '../model/review';
import { Usermodel } from '../model/users';
import { StatusCode } from '../statuscode';

class ReviewDomain {

    //POST Review
    async postReview(req: Request, res: Response) {
        var nextID: any = await reviewmodel.findOne({}, { _id: 1 }).sort({ _id: -1 });
        var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
        console.log(reqData)
        var uid: String = reqData.uid;
        var rating: Number = (Number(req.body.cleanliness) + Number(req.body.comfort) + Number(req.body.location) + Number(req.body.facilities)) / 4;
        var hotelId: Number = parseInt(req.params.id);
        var postData: object = {
            _id: nextID?._id == undefined ? 1 : Number(nextID?.id) + 1,
            user_id: uid,
            hotel_id: hotelId,
            date: Date.now(),
            comment: req.body.comment,
            cleanliness: req.body.cleanliness,
            comfort: req.body.comfort,
            location: req.body.location,
            facilities: req.body.facilities,
            rating: rating
        }
        console.log(postData);
        var data = new reviewmodel(postData);
        try {
            await data.save();
            var hotelReview = await reviewmodel.find({ hotel_id: req.params.id }).populate({ path: 'user_id', model: Usermodel, select: { 'user_name': 1, 'user_image': 1, '_id': 0 } });
            if (hotelReview.length == 0) {
                res.status(StatusCode.Not_Found).send([]);
            }
            else {
                console.log(hotelReview);
                res.status(StatusCode.Sucess).send(hotelReview);
            }
            // res.status(StatusCode.Sucess).send("data added ");
        }
        catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
        }
        res.end();
    }

    // GET Hotel Review
    async getHotelReview(req: Request, res: Response) {
        try {
            var hotelReview = await reviewmodel.find({ hotel_id: req.params.id }).populate({ path: 'user_id', model: Usermodel, select: { 'user_name': 1, 'user_image': 1, '_id': 0 } });
            if (hotelReview.length == 0) {
                res.status(StatusCode.Sucess).send([]);
            }
            else {
                res.status(StatusCode.Sucess).send(hotelReview);
            }
        }
        catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
        }
        res.end();
    }

}

//EXPORT
export { ReviewDomain };