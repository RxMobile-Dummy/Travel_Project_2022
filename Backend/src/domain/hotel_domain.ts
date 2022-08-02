import { hotelmodel } from "../model/hotel";
import { citymodel } from "../model/city";
import { statemodel } from "../model/state";
import { StatusCode } from "../statuscode";
import { imagemodel } from "../model/image";
import { bookmarkmodel } from "../model/bookmark";
import express, { Express, Request, Response } from 'express'

class HotelDomain {

    async getAllHotel(req: Request, res: Response) {
        try {
            var getHotelFullDetails = await hotelmodel.find().populate({
                path: 'address',
                populate: { path: 'city_id ', model: citymodel, populate: { model: statemodel, path: 'state_id' } }
            });
            res.status(StatusCode.Sucess).send(getHotelFullDetails);
            res.end();
        } catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();
        }
    }


    //get hotel image based on ui send limit of needed image
    async getHotelImage(req: Request, res: Response) {
        try {
            var imageData = await imagemodel.find({ room_id: null }).limit(parseInt(req.params.imagelimit));

            if (imageData) {
                res.status(200).send(imageData);
            } else {
                res.status(404).send("can't find Image");
            }

            res.end();
        } catch (e: any) {
            res.status(500).send(e.message);
            res.end();
        }
    }


    // get hotel by search [city wise or hotel name wise]
    async getHotelBySearch(req: Request, res: Response) {
        try {
            var hotelSearchParams: String = req.params.hotelsearch;
            var city: any = await citymodel.findOne({ city_name: { $regex: hotelSearchParams + '.*', $options: 'i' } })
            var cityId: Number = city?._id;
            var hoteBySerch: any = await hotelmodel.aggregate([
                {
                    $match: {
                        $or: [{ "address.city_id": cityId },
                        { hotel_name: { $regex: hotelSearchParams + '.*', $options: 'i' } }]

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
            if (hoteBySerch.length == 0) {
                res.status(StatusCode.Not_Found).send("No Hotel Found")
                res.end()
            } else {
                res.status(StatusCode.Sucess).send(hoteBySerch);
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
            var cityParams: String = req.params.cityname
            var noOfRoom: Number = parseInt(req.params.roomcount);
            var city: any = await citymodel.findOne({ city_name: cityParams })
            var cityId: Number = city?._id;
            var hoteByCityRoom: any = await hotelmodel.aggregate([
                {
                    $match: {
                        $and: [{ "address.city_id": cityId },
                        { "no_of_room": { $gte: noOfRoom } },

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
            if (hoteByCityRoom.length == 0) {
                res.status(StatusCode.Not_Found).send("No Hotel Found")
                res.end()
            } else {
                res.status(StatusCode.Sucess).send(hoteByCityRoom);
                res.end();
            }

        }
        catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();

        }
    }

    // get perticular hotel
    async getParticularHotel(req: Request, res: Response) {
        try {
            var reqData = JSON.parse(JSON.stringify(req.headers['data']));
            var bookmark;
            var uId = reqData.uid;
            if (reqData.provider != 'anyonums' && reqData.email != null) {
                let dataBook = await bookmarkmodel.find({ $and: [{ hotel_id: req.params.hotel_id }, { user_id: uId }] });
                if (dataBook.length != 0) {
                    bookmark = true;
                } else {
                    bookmark = false;
                }
            } else {
                bookmark = false;
            }
            var hotelData = await hotelmodel.aggregate([
                { $match: { "_id": parseInt(req.params.hotel_id) } },
                {
                    $lookup: {
                        from: 'images',
                        localField: '_id',
                        foreignField: 'hotel_id',
                        pipeline: [
                            { $match: { "room_id": null } }
                        ],
                        as: 'images'
                    }
                }, {
                    $project: {
                        "_id": 1,
                        "hotel_name": 1,
                        "rating": 1,
                        "address": 1,
                        "description": 1,
                        "phone_number": 1,
                        "price": 1,
                        "features": 1,
                        'images': 1
                    }
                },
            ])
            const d = hotelData[0];
            const responseData = {
                _id: d._id,
                hotel_name: d.hotel_name,
                rating: d.rating,
                address: d.address,
                description: d.description,
                price: d.price,
                features: d.features,
                phone_number: d.phone_number,
                images: d.images,
                isbookmark: bookmark
            }
            res.status(StatusCode.Sucess).send(responseData);
            res.end();
        } catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();
        }
    }
}
export { HotelDomain };
