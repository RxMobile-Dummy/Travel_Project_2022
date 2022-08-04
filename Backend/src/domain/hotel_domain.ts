import { hotelmodel } from "../model/hotel";
import { citymodel } from "../model/city";
import { statemodel } from "../model/state";
import { StatusCode } from "../statuscode";
import { imagemodel } from "../model/image";
import { bookmarkmodel } from "../model/bookmark";
import { AvailabilityDomain } from "./availability_domain";
import express, { Express, Request, Response } from 'express'

class HotelDomain {
    //Get All hotel list
    async getAllHotel(req: Request, res: Response) {
        try {
            var hoteBySerch: any = await hotelmodel.aggregate([
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
                res.status(StatusCode.Sucess).send("No Hotel Found")
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

    //get hotel image based on ui send limit of needed image
    async getHotelImage(req: Request, res: Response) {
        try {

            var hotelData = await hotelmodel.aggregate([
                { $match: { rating: { $gte: 5 } } },
                { $sample: { size: parseInt(req.params.imagelimit) } },
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
                        'Images': "$Images"
                    }
                },
            ])
            res.status(StatusCode.Sucess).send(hotelData);
            res.end();
        } catch (e: any) {
            res.status(StatusCode.Server_Error).send(e.message);
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
                        { "address.address_line": { $regex: hotelSearchParams + '.*', $options: 'i' } },
                        { "address.pincode": { $regex: hotelSearchParams + '.*', $options: 'i' } },
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
                res.status(StatusCode.Sucess).send([])
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


    // get perticular hotel
    async getParticularHotel(req: Request, res: Response) {
        try {
            var bookmark;
            if (req.headers['token'] != null) {
                var reqData = JSON.parse(JSON.stringify(req.headers['data']));

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



    async getHotelFilterList(req: Request, res: Response) {
        var q: any = req.query;
        try {

            const availabilityDomain = new AvailabilityDomain();

            if (q.cin.length != 0 && q.cout.length != 0 && q.no_of_room.length != 0 && q.type.length != 0 && q.id.length != 0) {

                //query params data
                const cIn: Date = new Date(q.cin);
                const cOut: Date = new Date(q.cout);
                const noOfRoom: any = q.no_of_room;
                const type: any = q.type;
                const id: any = q.id;

                const hotelIdArray: any = [];
                var avilHotelId: any = [];

                //If particular hotel is searched
                if (type == "hotel") {

                    //availabilty check
                    var hotelId = await availabilityDomain.checkAvailability(cIn, cOut, id, noOfRoom);
                    if (hotelId != null) {

                        //if hotel is available
                        avilHotelId.push(hotelId)

                    }

                }
                //city based hotel searched
                else if (type == "area") {

                    //city id based hotellist find
                    var cityBasedSerch = await hotelmodel.find({ 'address.city_id': id });

                    await Promise.all(cityBasedSerch.map(async (e: any) => {
                        hotelIdArray.push(e._id);

                        //availabilty check
                        var hotelId = await availabilityDomain.checkAvailability(cIn, cOut, e._id, noOfRoom);
                        if (hotelId != null) {

                            //if hotel is available
                            avilHotelId.push(hotelId);
                        }

                    }))

                } else {
                    res.send('params is not match');
                    res.end();
                }

                //available hotel list casting in number
                var avilHotelId = avilHotelId.map(Number);

                if (avilHotelId != null) {

                    //query params for filter
                    var ratingParams = q.rating.split(",").map(Number);
                    var priceParams = q.price.split("-").map(Number);
                    var featuresParams = q.features.split(",");

                    var flag: boolean = false;

                    //price default if params is single  
                    q.price.length == 0 ? (null) : (priceParams.length == 1 ? (priceParams[1] = 100000) : (flag = false));

                    var resData: any = [];

                    await Promise.all(

                        avilHotelId.map(async (e: any) => {

                            //if filter is not apply
                            if (q.rating.length == 0 && q.price.length == 0 && q.features.length == 0) {
                                var hotelfilterlist = await hotelmodel.aggregate(
                                    [{
                                        $match: { _id: e },
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
                                    ]
                                )
                            }
                            // if filter is apply
                            else {

                                var hotelfilterlist = await hotelmodel.aggregate(
                                    [{
                                        $match: {
                                            $and: [{ _id: e }, {
                                                $or: [{ rating: { $in: ratingParams } },
                                                { price: { $gte: priceParams[0], $lte: priceParams[1] } },
                                                { features: { $in: featuresParams } }
                                                ]
                                            }]
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
                                    ]
                                )
                            }

                            if (hotelfilterlist.length != 0) {
                                resData.push(hotelfilterlist[0]);
                            }
                        })
                    )
                    if(resData.length!=0){
                        res.status(StatusCode.Sucess).send(resData);
                        res.end();
                    }else{
                        res.status(StatusCode.Sucess).send([]);
                        res.end();
                    }
                }
            }

        } catch (err:any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();
        }
    }
}
export { HotelDomain };
