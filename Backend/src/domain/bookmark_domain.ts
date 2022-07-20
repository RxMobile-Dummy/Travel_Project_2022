import { bookmarkmodel } from '../model/bookmark';
import express, { Express, Request, Response } from 'express';
import { hotelmodel } from '../model/hotel';
import { imagemodel } from "../model/image";
import { StatusCode } from '../statuscode';
class BookmarkDomain {
    async postBookmark(req: Request, res: Response) {

        var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
        var uId: String = reqData.uid;
        var nextID = await bookmarkmodel.findOne({}, { _id: 1 }).sort({ _id: -1 });
        var postData: object = {
            _id: nextID?._id == undefined ? 1 : Number(nextID?.id) + 1,
            hotel_id: parseInt(req.params.hotel_id),
            user_id: uId
        }
        var data = new bookmarkmodel(postData);
        try {
            await data.save();
            res.status(StatusCode.Sucess).send("Data Post Success");
        }
        catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();
        }

    }

    async deleteBookmark(req: Request, res: Response) {
        try {
            var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
            var uId: String = reqData.uid;
            await bookmarkmodel.deleteOne({ $and: [{ hotel_id: parseInt(req.params.hotel_id) }, { user_id: uId }] }).then(() => {
                res.status(StatusCode.Sucess).send("Deleted");
                res.end();
            })
        } catch (error: any) {
            res.status(StatusCode.Server_Error).send(error.message);
            res.end();
        }

    }

    async userBookmark(req: Request, res: Response) {
        try {
            var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
            var uid = reqData.uid;
            var resImageData: any;
            var wishList: any = [];
            var bookmarkData = await bookmarkmodel.find({ user_id: uid }, { "hotel_id": 1 }).populate({ path: "hotel_id", model: hotelmodel, select: { "hotel_name": 1, "address": 1, "price": 1 } });
            if (bookmarkData.length != 0) {
                resImageData = Promise.all(
                    bookmarkData.map(async (e: any) => {
                        let image = await imagemodel.find({ $and: [{ room_id: e.room_id }, { hotel_id: e.hotel_id._id }] })
                        wishList.push({
                            "_id": e._id,
                            "hotel_name": e.hotel_id.hotel_name,
                            "address": e.hotel_id.address,
                            "price": e.hotel_id.price,
                            "image": image
                        });
                        return wishList;
                    })
                );
                resImageData.then((f: any) => {
                    res.status(StatusCode.Sucess).send(f[f.length - 1]);
                })
            } else {
                res.status(StatusCode.Sucess).send("No hotel in your wishlist")
            }
        } catch (error: any) {
            res.status(StatusCode.Server_Error).send(error.message);
            res.end();
        }

    }
}
export { BookmarkDomain };