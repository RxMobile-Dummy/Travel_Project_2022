import { hotelmodel } from "../model/hotel";
import { citymodel } from "../model/city";
import { statemodel } from "../model/state";
import { StatusCode } from "../statuscode";
import { imagemodel } from "../model/image";
import { bookmarkmodel } from "../model/bookmark";
import { Usermodel } from '../model/users';
import { AvailabilityDomain } from "./availability_domain";
import express, { Express, Request, Response } from 'express'
import { getStorage, ref, deleteObject } from "@firebase/storage";

class HotelDomain {
    //Get All hotel list
    async getAllHotel(req: Request, res: Response) {
        var pageSize: any = req.query.pagesize;
        var page: any = req.query.page;
        try {
            var hoteBySerch: any = await hotelmodel.aggregate([
                { $sort: { _id: 1 } },
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

            ]).skip((parseInt(pageSize) * parseInt(page))).limit(parseInt(pageSize));
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
                { $match: { rating: { $gte: 4 } } },
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
                var pageSize: any = q.pagesize ? parseInt(q.pagesize) : 0;
                var page: any = q.page ? parseInt(q.page) : 0;
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
                    var cityBasedSerch = await hotelmodel.find({ 'address.city_id': id }).limit(parseInt(pageSize)).skip(parseInt(pageSize) * parseInt(page));;

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
                    res.status(StatusCode.Sucess).send('params is not match');
                    res.end();
                }

                //available hotel list casting in number
                var avilHotelId = avilHotelId.map(Number);

                if (avilHotelId != null) {

                    //query params for filter
                    var ratingParams = q.rating.split(",").map(Number);
                    var max: any = Math.max(...ratingParams);
                    var min: any = Math.min(...ratingParams);
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
                                                $or: [
                                                    { $or: [{ rating: { $gte: min } }, { rating: { $gte: max } }] },
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
                    if (resData.length != 0) {
                        res.status(StatusCode.Sucess).send(resData);
                        res.end();
                    } else {
                        res.status(StatusCode.Sucess).send([]);
                        res.end();
                    }
                }
            }

        } catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();
        }
    }


    //add hotel 
    async addHotel(req: Request, res: Response) {
        var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
        var uid: string = reqData.uid;
        var userData = await Usermodel.find({ _id: uid }).select("-__v");
        if (reqData.admin == true) {
            var newHotelData = req.body;
            var nextID: any = await imagemodel.findOne({}, { _id: 1 }).sort({ _id: -1 });
            var last = await hotelmodel.find({}).sort({ _id: -1 }).limit(1);
            console.log(last[0]._id);
            var newId = last[0]._id;
            newHotelData._id = newId + 1;
            console.log(last);
            var room: any = [];

            var noOfDelux = req.body.noofdeluxe;
            var noOfSuperDeluxe = req.body.noodsuperdeluxe;
            var noOfSemiDeluxe = req.body.noofsemideluxe;

            var i: any;
            var j: any;
            for (i = 0; i < noOfDelux; i++) {
                var deluxRoomDetails = {
                    "room_id": ((newHotelData._id) * 100) + (i + 1),
                    "room_type": "Deluxe",
                    "room_size": req.body.deluxesize,
                    "bed_size": req.body.deluxebadsize,
                    "max_capacity": req.body.deluxemaxcapacity,
                    "price": req.body.deluxeprice,
                    "features": req.body.deluxefeatures,
                    "description": req.body.deluxedescription
                }
                room.push(deluxRoomDetails);
            }

            for (i = 0; i < noOfSemiDeluxe; i++) {
                var semideluxRoomDetails = {
                    "room_id": ((newHotelData._id) * 100) + (i + 1 + noOfDelux),
                    "room_type": "Semi-Deluxe",
                    "room_size": req.body.semideluxesize,
                    "bed_size": req.body.semideluxebadsize,
                    "max_capacity": req.body.semideluxemaxcapacity,
                    "price": req.body.semideluxeprice,
                    "features": req.body.semideluxefeatures,
                    "description": req.body.semideluxedescription
                }
                room.push(semideluxRoomDetails);
            }

            for (i = 0; i < noOfSuperDeluxe; i++) {
                var superdeluxRoomDetails = {
                    "room_id": ((newHotelData._id) * 100) + (i + 1 + noOfSemiDeluxe + noOfDelux),
                    "room_type": "Super-Deluxe",
                    "room_size": req.body.superdeluxesize,
                    "bed_size": req.body.superdeluxebadsize,
                    "max_capacity": req.body.superdeluxemaxcapacity,
                    "price": req.body.superdeluxeprice,
                    "features": req.body.superdeluxefeatures,
                    "description": req.body.superdeluxedescription
                }
                room.push(superdeluxRoomDetails);
            }


            newHotelData.room = room;
            var deluxroomID: any = [];
            var semideluxroomID: any = [];
            var superdeluxroomID: any = [];


            for (i = 0; i < room.length; i++) {
                if (room[i].room_type == 'Super-Deluxe') {
                    superdeluxroomID.push(room[i].room_id)
                }
                if (room[i].room_type == 'Semi-Deluxe') {
                    semideluxroomID.push(room[i].room_id)
                }
                if (room[i].room_type == 'Deluxe') {
                    deluxroomID.push(room[i].room_id)
                }
            }
            console.log("deluxroomID", deluxroomID)
            console.log("semideluxroomID", semideluxroomID)
            console.log("superdeluxroomID", superdeluxroomID)



            var hotelimagedata: any = [];

            for (i = 0; i < req.body.hotelimages.length; i++) {
                var images = {
                    "image_url": req.body.hotelimages[i],
                    "hotel_id": newHotelData._id,
                    "room_id": null,
                    "tour_id": null,
                    "user_id": null
                }
                hotelimagedata.push(images)

            }
            for (j = 0; j < deluxroomID.length; j++) {
                for (i = 0; i < req.body.deluxeimages.length; i++) {
                    var deluximages = {
                        "image_url": req.body.deluxeimages[i],
                        "hotel_id": newHotelData._id,
                        "room_id": deluxroomID[j],
                        "tour_id": null,
                        "user_id": null
                    }
                    hotelimagedata.push(deluximages)

                }
            }
            for (j = 0; j < semideluxroomID.length; j++) {
                for (i = 0; i < req.body.semideluxeimages.length; i++) {
                    var semideluximages = {
                        "image_url": req.body.semideluxeimages[i],
                        "hotel_id": newHotelData._id,
                        "room_id": semideluxroomID[j],
                        "tour_id": null,
                        "user_id": null
                    }
                    hotelimagedata.push(semideluximages)

                }
            }
            for (j = 0; j < superdeluxroomID.length; j++) {
                for (i = 0; i < req.body.superdeluxeimages.length; i++) {
                    var superdeluximages = {
                        "image_url": req.body.superdeluxeimages[i],
                        "hotel_id": newHotelData._id,
                        "room_id": superdeluxroomID[j],
                        "tour_id": null,
                        "user_id": null
                    }
                    hotelimagedata.push(superdeluximages)

                }
            }

            for (i = 0; i < hotelimagedata.length; i++) {
                hotelimagedata[i]._id = nextID._id + i + 1;
            }

            var data = new hotelmodel(newHotelData);


            var hoteId = {
                "hotel_id": newHotelData._id,
                "message ": "Your hotel data sucefully saved"
            }
            try {
                await data.save();
                imagemodel.insertMany(hotelimagedata, function (err: any, result: any) {
                    if (err) throw err;
                    console.log("saved")
                });
                res.status(StatusCode.Sucess).send(hoteId);
            }
            catch (err: any) {
                res.status(StatusCode.Error).send(err.message);
            }
        } else {
            res.status(StatusCode.Unauthorized).send("you are not authorize")
        }
    }




    //update hotel
    async updateHotel(req: Request, res: Response) {
        var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
        var uid: string = reqData.uid;
        var userData = await Usermodel.find({ _id: uid }).select("-__v");
        if (reqData.admin == true) {
            var newHotelData = req.body;
            const storage = getStorage();
            var room: any = []
            var noOfDelux = req.body.noofdeluxe;
            var noOfSuperDeluxe = req.body.noodsuperdeluxe;
            var noOfSemiDeluxe = req.body.noofsemideluxe;
            var i: any;
            if (newHotelData._id > 50) {
                for (i = 0; i < noOfDelux; i++) {
                    var deluxRoomDetails = {
                        "room_id": ((newHotelData._id) * 100) + (i + 1),
                        "room_type": "Deluxe",
                        "room_size": req.body.deluxesize,
                        "bed_size": req.body.deluxebadsize,
                        "max_capacity": req.body.deluxemaxcapacity,
                        "price": req.body.deluxeprice,
                        "features": req.body.deluxefeatures,
                        "description": req.body.deluxedescription
                    }
                    room.push(deluxRoomDetails);
                }
                for (i = 0; i < noOfSemiDeluxe; i++) {
                    var semideluxRoomDetails = {
                        "room_id": ((newHotelData._id) * 100) + (i + 1 + noOfDelux),
                        "room_type": "Semi-Deluxe",
                        "room_size": req.body.semideluxesize,
                        "bed_size": req.body.semideluxebadsize,
                        "max_capacity": req.body.semideluxemaxcapacity,
                        "price": req.body.semideluxeprice,
                        "features": req.body.semideluxefeatures,
                        "description": req.body.semideluxedescription
                    }
                    room.push(semideluxRoomDetails);
                }
                for (i = 0; i < noOfSuperDeluxe; i++) {
                    var superdeluxRoomDetails = {
                        "room_id": ((newHotelData._id) * 100) + (i + 1 + noOfSemiDeluxe + noOfDelux),
                        "room_type": "Super-Deluxe",
                        "room_size": req.body.superdeluxesize,
                        "bed_size": req.body.superdeluxebadsize,
                        "max_capacity": req.body.superdeluxemaxcapacity,
                        "price": req.body.superdeluxeprice,
                        "features": req.body.superdeluxefeatures,
                        "description": req.body.superdeluxedescription
                    }
                    room.push(superdeluxRoomDetails);
                }
                var deluxroomID: any = [];
                var semideluxroomID: any = [];
                var superdeluxroomID: any = [];
                for (i = 0; i < room.length; i++) {
                    if (room[i].room_type == 'Super-Deluxe') {
                        superdeluxroomID.push(room[i].room_id)
                    }
                    if (room[i].room_type == 'Semi-Deluxe') {
                        semideluxroomID.push(room[i].room_id)
                    }
                    if (room[i].room_type == 'Deluxe') {
                        deluxroomID.push(room[i].room_id)
                    }
                }
                console.log("deluxroomID", deluxroomID)
                console.log("semideluxroomID", semideluxroomID)
                console.log("superdeluxroomID", superdeluxroomID)
                var i: any;
                var j: any;
                var hotelimagedata: any = [];
                for (i = 0; i < req.body.hotelimages.length; i++) {
                    var images = {
                        "image_url": req.body.hotelimages[i],
                        "hotel_id": newHotelData._id,
                        "room_id": null,
                        "tour_id": null,
                        "user_id": null
                    }
                    hotelimagedata.push(images)
                }
                for (j = 0; j < deluxroomID.length; j++) {
                    for (i = 0; i < req.body.deluxeimages.length; i++) {
                        var deluximages = {
                            "image_url": req.body.deluxeimages[i],
                            "hotel_id": newHotelData._id,
                            "room_id": deluxroomID[j],
                            "tour_id": null,
                            "user_id": null
                        }
                        hotelimagedata.push(deluximages)
                    }
                }
                for (j = 0; j < semideluxroomID.length; j++) {
                    for (i = 0; i < req.body.semideluxeimages.length; i++) {
                        var semideluximages = {
                            "image_url": req.body.semideluxeimages[i],
                            "hotel_id": newHotelData._id,
                            "room_id": semideluxroomID[j],
                            "tour_id": null,
                            "user_id": null
                        }
                        hotelimagedata.push(semideluximages)
                    }
                }
                for (j = 0; j < superdeluxroomID.length; j++) {
                    for (i = 0; i < req.body.superdeluxeimages.length; i++) {
                        var superdeluximages = {
                            "image_url": req.body.superdeluxeimages[i],
                            "hotel_id": newHotelData._id,
                            "room_id": superdeluxroomID[j],
                            "tour_id": null,
                            "user_id": null
                        }
                        hotelimagedata.push(superdeluximages)
                    }
                }
                await imagemodel.deleteMany({ hotel_id: req.body._id }, function (err) {
                    if (!err) {
                        console.log("Image deleted")
                    }
                    else {
                        console.log("Error in deleeting");

                    }
                });

                var nextID: any = await imagemodel.findOne({}, { _id: 1 }).sort({ _id: -1 });
                for (i = 0; i < hotelimagedata.length; i++) {
                    hotelimagedata[i]._id = nextID._id + i + 1;
                }
                var hoteldata = await hotelmodel.findOne({ _id: req.body._id });
                console.log(hoteldata!.room.length);
                var deluxId: any = [];
                var superdeluxId: any = [];
                var semideluxId: any = [];
                hoteldata!.room.forEach((e: any) => {
                    if (e.room_type == 'Semi-Deluxe') {
                        semideluxId.push(e.room_id);
                    }
                    if (e.room_type == 'Deluxe') {
                        deluxId.push(e.room_id);
                    }
                    if (e.room_type == 'Super-Deluxe') {
                        superdeluxId.push(e.room_id);
                    }
                });
                console.log("delux", deluxId)
                console.log("superdelux", superdeluxId)
                console.log("semidelux", semideluxId)
                var orghoteimagedata: any = [];
                var orgdeluxeimagedata: any = [];
                var orgsemideluxeimagedata: any = [];
                var orgsuperdeluxeimagedata: any = [];
                var hotelimage = await imagemodel.find({ $and: [{ hotel_id: req.body._id }, { room_id: null }] }).select("image_url")
                var deluxeimage = await imagemodel.find({ $and: [{ hotel_id: req.body._id }] }).select("image_url")
                var superdeluxeimage = await imagemodel.find({ $and: [{ hotel_id: req.body._id }, { room_id: { $in: superdeluxId } }] }).select("image_url")
                var semideluxeimage = await imagemodel.find({ $and: [{ hotel_id: req.body._id }, { room_id: { $in: semideluxId } }] }).select("image_url")
                hotelimage.forEach((e: any) => {
                    if (!orghoteimagedata.includes(e.image_url)) {
                        orghoteimagedata.push(e.image_url)
                    }
                })
                deluxeimage.forEach((e: any) => {
                    if (!orgdeluxeimagedata.includes(e.image_url)) {
                        orgdeluxeimagedata.push(e.image_url)
                    }
                })
                superdeluxeimage.forEach((e: any) => {
                    if (!orgsuperdeluxeimagedata.includes(e.image_url)) {
                        orgsuperdeluxeimagedata.push(e.image_url)
                    }
                })
                semideluxeimage.forEach((e: any) => {
                    if (!orgsemideluxeimagedata.includes(e.image_url)) {
                        orgsemideluxeimagedata.push(e.image_url)
                    }
                })
                console.log("orghoteimagedata", orghoteimagedata);
                console.log("orgdeluxeimagedata", orgdeluxeimagedata);
                console.log("orgsemideluxeimagedata", orgsemideluxeimagedata);
                console.log("orgsuperdeluxeimagedata", orgsuperdeluxeimagedata);
                console.log("updhoteimagedata", req.body.hotelimages);
                console.log("upddeluxeimagedata", req.body.deluxeimages);
                console.log("updsemideluxeimagedata", req.body.semideluxeimages);
                console.log("updsuperdeluxeimagedata", req.body.superdeluxeimages);

                var delhotelimagedata = orghoteimagedata.filter((x: any) => !(req.body.hotelimages).includes(x));
                var deldeluxeimagedata = orgdeluxeimagedata.filter((x: any) => !(req.body.deluxeimages).includes(x));
                var delsemideluxeimagedata = orgsemideluxeimagedata.filter((x: any) => !(req.body.semideluxeimages).includes(x));
                var delsuperdeluxeimagedata = orgsuperdeluxeimagedata.filter((x: any) => !(req.body.superdeluxeimages).includes(x));

                console.log("delhotelimagedata", delhotelimagedata)
                console.log("deldeluxeimagedata", deldeluxeimagedata)
                console.log("delsemideluxeimagedata", delsemideluxeimagedata)
                console.log("delsuperdeluxeimagedata", delsuperdeluxeimagedata)

                delhotelimagedata.forEach((e: any) => {
                    const desertRef = ref(storage, e);
                    deleteObject(desertRef).then(() => {
                        console.log("deleted")
                    }).catch((error) => {
                        console.log(error);
                    });
                })
                deldeluxeimagedata.forEach((e: any) => {
                    const desertRef = ref(storage, e);
                    deleteObject(desertRef).then(() => {
                        console.log("deleted")
                    }).catch((error) => {
                        console.log(error);
                    });
                })
                delsemideluxeimagedata.forEach((e: any) => {
                    const desertRef = ref(storage, e);
                    deleteObject(desertRef).then(() => {
                        console.log("deleted")
                    }).catch((error) => {
                        console.log(error);
                    });
                })
                delsuperdeluxeimagedata.forEach((e: any) => {
                    const desertRef = ref(storage, e);
                    deleteObject(desertRef).then(() => {
                        console.log("deleted")
                    }).catch((error) => {
                        console.log(error);
                    });
                })

                newHotelData.room = room;
                try {
                    var data = req.body;
                    imagemodel.insertMany(hotelimagedata, function (err: any, result: any) {
                        if (err) throw err;
                        console.log("Image sucessfully added");
                    });
                    // await hotelmodel.updateOne({ _id: data._id }, data)
                    res.status(StatusCode.Sucess).send(data);
                }
                catch (err: any) {
                    res.send(err.message);
                }
            } else {
                res.status(StatusCode.Sucess).send("you can not update , sorry from backend")
            }
        } else {
            res.status(StatusCode.Unauthorized).send("you are not authorize")
        }
    }


    async getHotelDataForUpdate(req: Request, res: Response) {
        console.log(req.params.hotelid);
        var hoteldata = await hotelmodel.findOne({ _id: req.params.hotelid });
        console.log(hoteldata!.room.length);
        var deluxId: any = [];
        var superdeluxId: any = [];
        var semideluxId: any = [];
        var semiDeluxData: any;
        var superDeluxData: any;
        var deluxData: any;
        hoteldata!.room.forEach((e: any) => {
            if (e.room_type == 'Semi-Deluxe') {
                semideluxId.push(e.room_id);
            }
            if (e.room_type == 'Deluxe') {
                deluxId.push(e.room_id);
            }
            if (e.room_type == 'Super-Deluxe') {
                superdeluxId.push(e.room_id);
            }
            if (e.room_type == "Deluxe" && deluxData == null) {
                deluxData = (JSON.parse(JSON.stringify(e)));
            }
            if (e.room_type == "Semi-Deluxe" && semiDeluxData == null) {
                semiDeluxData = (JSON.parse(JSON.stringify(e)));
            }
            if (e.room_type == "Super-Deluxe" && superDeluxData == null) {
                superDeluxData = (JSON.parse(JSON.stringify(e)));
            }
        });
        console.log("delux", deluxId)
        console.log("superdelux", superdeluxId)
        console.log("semidelux", semideluxId)

        var hoteimagedata: any = [];
        var deluxeimagedata: any = [];
        var semideluxeimagedata: any = [];
        var superdeluxeimagedata: any = [];

        var hotelimage = await imagemodel.find({ $and: [{ hotel_id: req.params.hotelid }, { room_id: null }] }).select("image_url")
        var deluxeimage = await imagemodel.find({ $and: [{ hotel_id: req.params.hotelid }, { room_id: { $in: deluxId } }] })
        var superdeluxeimage = await imagemodel.find({ $and: [{ hotel_id: req.params.hotelid }, { room_id: { $in: superdeluxId } }] })
        var semideluxeimage = await imagemodel.find({ $and: [{ hotel_id: req.params.hotelid }, { room_id: { $in: semideluxId } }] })
        console.log(hotelimage)
        hotelimage.forEach((e: any) => {
            if (!hoteimagedata.includes(e.image_url)) {
                hoteimagedata.push(e.image_url)
            }

        })
        deluxeimage.forEach((e: any) => {
            if (!deluxeimagedata.includes(e.image_url)) {
                deluxeimagedata.push(e.image_url)
            }

        })
        superdeluxeimage.forEach((e: any) => {
            if (!superdeluxeimagedata.includes(e.image_url)) {
                superdeluxeimagedata.push(e.image_url)
            }

        })
        semideluxeimage.forEach((e: any) => {
            if (!semideluxeimagedata.includes(e.image_url)) {
                semideluxeimagedata.push(e.image_url)
            }

        })
        console.log(hoteimagedata);
        var hotelResponseData = {
            "_id": hoteldata!._id,
            "hotel_name": hoteldata!.hotel_name,
            "address": {
                "address_line": hoteldata!.address!.address_line,
                "city_id": hoteldata!.address!.city_id,
                "pincode": hoteldata!.address!.pincode,
                "location": {
                    "latitude": hoteldata!.address!.location!.latitude,
                    "longitude": hoteldata!.address!.location!.latitude
                }
            },
            "rating": hoteldata!.rating,
            "price": hoteldata!.price,
            "phone_number": hoteldata!.phone_number,
            "no_of_room": hoteldata!.no_of_room,
            "description": hoteldata!.description,
            "features": hoteldata!.features,
            "noofdeluxe": deluxId.length,
            "deluxesize": deluxData.room_size,
            "deluxebadsize": deluxData.bed_size,
            "deluxemaxcapacity": deluxData.max_capacity,
            "deluxeprice": deluxData.price,
            "deluxefeatures": deluxData.features,
            "deluxedescription": deluxData.description,
            "noofsemideluxe": semideluxId.length,
            "semideluxesize": semiDeluxData.room_size,
            "semideluxebadsize": semiDeluxData.bed_size,
            "semideluxemaxcapacity": semiDeluxData.max_capacity,
            "semideluxeprice": semiDeluxData.price,
            "semideluxefeatures": semiDeluxData.features,
            "semideluxedescription": semiDeluxData.description,
            "noodsuperdeluxe": superdeluxId.length,
            "superdeluxesize": superDeluxData.room_size,
            "superdeluxebadsize": superDeluxData.bed_size,
            "superdeluxemaxcapacity": superDeluxData.max_capacity,
            "superdeluxeprice": superDeluxData.price,
            "superdeluxefeatures": superDeluxData.features,
            "superdeluxedescription": superDeluxData.description,
            "hotelimages": hoteimagedata,
            "deluxeimages": deluxeimagedata,
            "semideluxeimages": semideluxeimagedata,
            "superdeluxeimages": superdeluxeimagedata

        }

        res.status(StatusCode.Sucess).send(hotelResponseData);
    }

    //delete hotel 
    async deleteHotel(req: Request, res: Response) {
        var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
        var uid: string = reqData.uid;
        var userData = await Usermodel.find({ _id: uid }).select("-__v");
        if (reqData.admin == true) {
            var hotelData = await hotelmodel.findOne({ _id: req.params.hoteId })
            if (hotelData) {
                hotelmodel.deleteOne({ _id: req.params.hoteId }, function (err) {
                    if (!err) {
                        //res.send("Delete sucesffully");
                        imagemodel.deleteMany({ hotel_id: req.params.hoteId }, function (err) {
                            if (!err) {
                                res.send("hotel and image Delete sucesffully");
                                res.end();
                            }
                            else {
                                res.send("Error in deleeting");
                                res.end();
                            }
                        });
                    }
                    else {
                        res.send("Error in deleeting");
                        res.end();
                    }
                });


            } else {
                res.send("Can not find hotel");
                res.end();
            }
        } else {
            res.status(StatusCode.Unauthorized).send("you are not authorize")
        }

    }



}
export { HotelDomain };
