import { hotelmodel } from "../model/hotel";
import { citymodel } from "../model/city";
import { statemodel } from "../model/state";
import { StatusCode } from "../statuscode";
import { imagemodel } from "../model/image";
import express, { Express, Request, Response } from 'express'


class HotelDomain {

    async getAllHotel(req: Request, res: Response) {
        try {
            var gethotelfulldetails = await hotelmodel.find().populate({
                path: 'addresss',
                populate: { path: 'city_id ', model: citymodel, populate: { model: statemodel, path: 'state_id' } }
            });
            res.status(StatusCode.Sucess).send(gethotelfulldetails);
            res.end();
        } catch (err:any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();
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
                res.status(StatusCode.Not_Found).send("No Data Found")
                res.end()
            } else {
                res.status(StatusCode.Sucess).send(hotebyserch);
                res.end();
            }
        } catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();

        }

    }


    //get hotel by city and room
    async getHotelByCityRoom(req: Request, res: Response) {
        try {
            var cityparams: String = req.params.cityname
            var noofroom: Number = parseInt(req.params.roomcount);
            var city: any = await citymodel.findOne({ city_name: cityparams })
            var cityid: Number = city?._id;
            var hotebycityroom: any = await hotelmodel.aggregate([
                {
                    $match: {
                        $and: [{ "address.city_id": cityid },
                        { "no_of_room": { $gte: noofroom } },
                        ]
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
                        "_id": 1,
                        "hotel_name": 1,
                        "rating": 1,
                        "address": 1,
                        "price": 1,
                        'Images': 1
                    }
                },


            ]);
            if (hotebycityroom.length == 0) {
                res.status(StatusCode.Not_Found).send("No Hotel Found")
                res.end()
            } else {
                res.status(StatusCode.Sucess).send(hotebycityroom);
                res.end();
            }

        }
        catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();

        }
    }





    //get hotel image based on ui send limit of needed image
    async getHotelImage(req: Request, res: Response) {
        try {
            var imageData = await imagemodel.find({ room_id: null }).limit(parseInt(req.params.imagelimit));

            if(imageData){
                res.status(200).send(imageData);
            }else{
                res.status(404).send("can't find Image");
            }

            res.end();
        } catch (e:any) {
            res.status(500).send(e.message);
            res.end();
        }
    }
}

export { HotelDomain };
