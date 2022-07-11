import { hotelmodel } from "../model/hotel";
import { citymodel } from "../model/city";
import { statemodel } from "../model/state";
import express, { Express, Request, Response } from 'express'


class HotelDomain {

    async getAllHotel(req: Request, res: Response) {
        try {
            var gethotelfulldetails = await hotelmodel.find().populate({
                path: 'addresss',
                populate: { path: 'city_id ', model: citymodel, populate: { model: statemodel, path: 'state_id' } }
            });
            res.send(gethotelfulldetails);
            res.end();
        } catch (e) {
            res.send(e)
        }
    }

    // get hotel by search [city wise or hotel name wise]
    async getHotelBySearch(req: Request, res: Response) {
        try {
            var hotelsearchparams: String = req.params.hotelsearch;
            var city: any = await citymodel.findOne({ city_name: { $regex: hotelsearchparams + '.*', $options: 'i' } })
            var cityid: Number = city?._id;
            var hotebyserch: any = await hotelmodel.aggregate([
                {
                    $match: {
                        $or: [{ "address.city_id": cityid },
                        { hotel_name: { $regex: hotelsearchparams + '.*', $options: 'i' } }]
                    }
                },
                {
                    $lookup: {
                        from: "images",
                        localField: "_id",
                        foreignField: "hotel_id",
                        pipeline: [
                            { $match: { room_id: null } }
                        ],
                        as: "Images",
                    },
                },
                {
                    "$project": {
                        "hotel_id": "$_id",
                        "hotel_name": "$hotel_name",
                        "rating": "$rating",
                        "address": "$address",
                        "price": "$price",
                        'Images': "$Images"
                    }
                },

            ]);
            if (hotebyserch.length == 0) {
                res.status(404).send("No Data Found")
                res.end()
            } else {
                res.status(200).send(hotebyserch);
                res.end();
            }
        } catch (err: any) {
            res.status(500).send(err.message);
            res.end();

        }

    }

}

export { HotelDomain };
