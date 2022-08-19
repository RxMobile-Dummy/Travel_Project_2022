import { bookingmodel } from "../model/booking";
import { StatusCode } from "../statuscode";
import { hotelmodel } from "../model/hotel";
import { imagemodel } from "../model/image";
import { couponmodel } from "../model/coupon"
import express, { Express, Request, Response } from 'express'
import * as admin from 'firebase-admin';
import { Usermodel } from "../model/users";
import schedule from 'node-schedule';
import { devicemodel } from "../model/device";

class BookingDomain {
    async addBooking(req: Request, res: Response) {
        var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
        var checkinDate = new Date(req.body.checkin_date).toISOString().toString().replace("T00:00:00.000Z", "T06:30:00.000Z");
        var checkoutDate = new Date(req.body.checkout_date).toISOString().toString().replace("T00:00:00.000Z", "T06:30:00.000Z")

        try {
            var nextID: any = await bookingmodel.findOne({}, { _id: 1 }).sort({ _id: -1 });
            var noOfRoom: Number = req.body.room_id.length
            var bookIngData: object = {
                _id: nextID?._id == undefined ? 1 : Number(nextID?.id) + 1,
                user_id: reqData.uid,
                hotel_id: req.body.hotel_id,
                no_of_room: noOfRoom,
                room_id: req.body.room_id,
                checkin_date: new Date(checkinDate),
                checkout_date: new Date(checkoutDate),
                price: {
                    number_of_nights: req.body.price.number_of_nights,
                    room_price: req.body.price.room_price,
                    gst: req.body.price.gst,
                    discount: req.body.price.discount,
                    total_price: req.body.price.total_price
                },
                status: "success"
            }
            var sum = 0;
            var rommIdFromReq: any = (req.body.room_id);
            // console.log(rommIdFromReq);
            var getHotelRoom = await hotelmodel.find({ _id: req.body.hotel_id })
            var roomPrice: any = [];
            getHotelRoom.forEach((e: any) => {
                e.room.forEach((d: any) => {
                    if (rommIdFromReq.includes(d.room_id)) {
                        roomPrice.push(d.price);
                        sum = sum + d.price;
                    }
                })
            })
            const getHotelRoomPrice: number = sum;
            // console.log(getHotelRoom);
            // console.log('price ' + getHotelRoomPrice);
            var totalPrize = (req.body.price.total_price);
            var noOfNight = (req.body.price.number_of_nights);
            var roomGstPrice = ((18 / 100) * (getHotelRoomPrice * noOfNight));
            var roomDiscountPrice = ((getHotelRoomPrice * noOfNight) + roomGstPrice) * 0.05;
            // console.log(`gst ${roomGstPrice}`);
            // console.log(`discount ${roomDiscountPrice}`);
            var roomTotalPrize = ((getHotelRoomPrice * noOfNight) - roomDiscountPrice + roomGstPrice)
            // console.log('price ' + roomTotalPrize);
            // console.log('total ' + totalPrize);
            if (roomTotalPrize == totalPrize) {
                var bookedData = new bookingmodel(bookIngData);
                // console.log(bookedData);
                await bookedData.save();

                
                // ****************************** FOR NOTIFICATION ****************************** //
               
                const notificationId = nextID?._id == undefined ? 1 : Number(nextID?.id) + 1  
                var currentBookingData = await bookingmodel.findById(notificationId);
                if(currentBookingData == null)
                {
                        console.log("order cancel no notification");
                        
                }
                else
                {
                const notification_options = {
                    priority: "high",
                    timeToLive: 60 * 60 * 24
                };
                
                // To find FCM token
                var userDevices = await devicemodel.find({useruid : "user1"});
                var registrationToken : any = [];
                userDevices.forEach(element => {
                    registrationToken.push(element.fcmtoken) ;
                 });   

                const options = notification_options
                var userData: any = await Usermodel.findById(reqData.uid);
                var hotelData: any = await hotelmodel.findById(req.body.hotel_id);

                const bookingSuccessfullMessage = {
                    "data": {"key" : "booking"},
                    "notification": {
                        "title": "Booking successfull",
                        "body": `Hi ${userData.user_name}, thanks for choosing to stay at ${hotelData.hotel_name}`
                    }

                }
                const before24hrsmessage = {
                    "data": {"key" : "booking"},
                    "notification": {
                        "title": "24 hours remaining",
                        "body": `Hi ${userData.user_name}, 24 hours remaining of your booking at ${hotelData.hotel_name}`
                    }
                }
                const before1hrmessage = {
                    "data": {"key" : "booking"},
                    "notification": {
                        "title": "1 hours remaining",
                        "body": `Hi ${userData.user_name}, only 1 hour remaining of your booking at ${hotelData.hotel_name}`
                    }
                }
                const after1hrmessage = {
                    "data": {"key" : "booking"},
                    "notification": {
                        "title": "Review",
                        "body": `Hi ${userData.user_name}, thanks for choosing to stay at ${hotelData.hotel_name} please give your feedback`
                    }
                }
                //later date for testing
                // var currentDate = new Date();
                // var laterDate1 = new Date(currentDate.getTime() + (0.105 * 60000));
                // var laterDate2 = new Date(currentDate.getTime() + (0.125 * 60000));
                // var laterDate3 = new Date(currentDate.getTime() + (0.165 * 60000));


                //Booking Successfull Notification
                admin.messaging().sendToDevice(registrationToken, bookingSuccessfullMessage, options);

                //24 hr before checkin date notification 
                var laterDate1 = new Date(new Date(checkinDate).getTime() - (24 * 60 * 60 * 1000));
                var job1 = schedule.scheduleJob(`${notificationId}1`, laterDate1, () => {
                    admin.messaging().sendToDevice(registrationToken, before24hrsmessage);

                });

                //1 hr before checkin date notification 
                var laterDate2 = new Date(new Date(checkinDate).getTime() - (1 * 60 * 60 * 1000));
                var job2 = schedule.scheduleJob(`${notificationId}2`, laterDate2, () => {
                    admin.messaging().sendToDevice(registrationToken, before1hrmessage);

                });

                //1 hr after check out date notification for review
                var laterDate3 = new Date(new Date(checkoutDate).getTime() + (1 * 60 * 60 * 1000));
                var job3 = schedule.scheduleJob(`${notificationId}3`, laterDate3, () => {
                    admin.messaging().sendToDevice(registrationToken, after1hrmessage);

                });
            }

                res.status(StatusCode.Sucess).send("Booking Success")
                res.end();
            }
            else {
                res.status(StatusCode.Not_Acceptable).send("Error in calculation");
            }

            //res.end();
        } catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();
        }
    }

    async roomBookAvailableCheck(req: Request, res: Response) {
        try {
            var q: any = req.query;
            const hotelId: string = q.hotel_id;
            const cIn: Date = new Date(q.cin);
            const cOut: Date = new Date(q.cout);
            const noofroom = q.no_of_room;
            const bookedId: any = [];
            const unAvailableRoomDupId: any = [];
            const unAvailableRoomId: any = [];
            const roomDetailList: any = [];
            var hotelName: any;
            //finding mattressprize
            var hotelMattress = await hotelmodel.findOne({ _id: parseInt(hotelId) }).select("mattressPrice");
            var hotelMattressPrize = hotelMattress?.mattressPrice ?? 0;
            //console.log(hotelMattressPrize);
            //booking table check checkIn and checkOut match with user checkIn & checkOut date
            const resData = await bookingmodel.find({
                $and: [{ hotel_id: hotelId },
                {
                    $or: [
                        { $and: [{ "checkin_date": { $lte: cIn } }, { "checkout_date": { $lte: cIn } }] },
                        { $and: [{ "checkin_date": { $gte: cOut } }, { "checkout_date": { $gte: cOut } }] }
                    ]
                }
                ]
            },
                {
                    "_id": 1,
                    "hotel_id": 1,
                    "checkin_date": 1,
                    "checkout_date": 1,
                    "room_id": 1
                });
            // console.log(resData);
            if (resData != null) {
                //booked ID from resData
                resData.forEach(e => {
                    bookedId.push(e._id);
                });
                const unAvailableBooking = await bookingmodel.find({ $and: [{ hotel_id: hotelId }, { _id: { $nin: bookedId } }] }, {
                    "_id": 1,
                    "hotel_id": 1,
                    "room_id": 1
                })
                //console.log("this is unavilablebooking " + unAvailableBooking);
                if (unAvailableBooking != null) {
                    //Available roomId 
                    unAvailableBooking.forEach(e => {
                        e.room_id.forEach(d => {
                            unAvailableRoomDupId.push(d);
                        })
                    })
                    //Duplication Remove in roomId
                    unAvailableRoomDupId.forEach((item: any) => {
                        if (!unAvailableRoomId.includes(item)) {
                            unAvailableRoomId.push(item);
                        }
                    })
                    // console.log("this unAvailableRoomId " + unAvailableRoomId);
                    var semiDeluxData: any;
                    var superDeluxData: any;
                    var deluxData: any;
                    //get hotel all room Id and subtract it from unAvailable
                    var hRoom = await hotelmodel.find({ _id: hotelId });
                    hRoom.forEach(e => {
                        hotelName = e.hotel_name;
                        e.room.forEach((c: any) => {
                            if (!unAvailableRoomId.includes(c.room_id)) {
                                roomDetailList.push(c);
                            }
                            if (c.room_type == "Deluxe" && deluxData == null) {
                                deluxData = (JSON.parse(JSON.stringify(c)));
                            }
                            if (c.room_type == "Semi-Deluxe" && semiDeluxData == null) {
                                semiDeluxData = (JSON.parse(JSON.stringify(c)));
                            }
                            if (c.room_type == "Super-Deluxe" && superDeluxData == null) {
                                superDeluxData = (JSON.parse(JSON.stringify(c)));
                            }
                        });
                    })
                    var deluxImage = await imagemodel.find({ $and: [{ room_id: deluxData.room_id }, { hotel_id: hotelId }] });
                    var superDeluxImage = await imagemodel.find({ $and: [{ room_id: semiDeluxData.room_id }, { hotel_id: hotelId }] });
                    var semideluxImage = await imagemodel.find({ $and: [{ room_id: semiDeluxData.room_id }, { hotel_id: hotelId }] });
                    deluxData.image = deluxImage;
                    superDeluxData.image = superDeluxImage;
                    semiDeluxData.image = semideluxImage;

                    const newDeluxIDList: any = [];
                    const newsemiDeluxIDList: any = [];
                    const newSuperDeluxIDList: any = [];
                    roomDetailList.forEach((a: any) => {
                        if (a.room_type == "Deluxe") {
                            newDeluxIDList.push(a.room_id);
                        }
                        else if (a.room_type == "Semi-Deluxe") {
                            newsemiDeluxIDList.push(a.room_id);
                        }
                        else if (a.room_type == "Super-Deluxe") {
                            newSuperDeluxIDList.push(a.room_id);
                        }
                    });
                    var resultData = {
                        "hotel_id": hotelId,
                        "hotel_name": hotelName,
                        "hotelMattressPrize": hotelMattressPrize,
                        "deluxe_room_id": newDeluxIDList,
                        "deluxe": deluxData,
                        "semideluxe_room_id": newsemiDeluxIDList,
                        "semideluxe": semiDeluxData,
                        "superdeluxe_room_id": newSuperDeluxIDList,
                        "supedeluxe": superDeluxData,
                    };
                    res.status(StatusCode.Sucess).send(resultData);

                } else {
                    res.status(StatusCode.Sucess).send({})
                    res.end()
                }
            } else {
                res.status(StatusCode.Sucess).send({
                })
                res.end()
            }
        } catch (error: any) {
            res.status(StatusCode.Server_Error).send(error.message);
            res.end();
        }
    }


    async userBookingHistory(req: Request, res: Response) {
        try {
            var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
            var uid: String = reqData.uid;
            var bookingData = await bookingmodel.find({ "user_id": uid });
            var hotelIdList: any = [];
            var bookingHistoryData: any = [];
            if (bookingData != null) {
                bookingData.forEach(e => {
                    hotelIdList.push(e.hotel_id);
                })
                var hotelData = await hotelmodel.aggregate([
                    {
                        $match: {
                            _id: { $in: hotelIdList }
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
                            as: "images",
                        },
                    },
                    {
                        "$project": {

                            "hotel_id": "$_id",
                            "hotel_name": "$hotel_name",
                            "address": "$address",
                            'images': "$images"
                        }
                    },

                ]);

                bookingData.forEach(e => {
                    hotelData.forEach(d => {
                        if (e.hotel_id == d._id) {
                            bookingHistoryData.push({
                                "booking_id": e._id,
                                "status": e.status,
                                "hotel_id": d._id,
                                "hotel_name": d.hotel_name,
                                "address": d.address,
                                'images': d.images,
                                "price": e.price?.total_price,
                                "no_of_room": e.no_of_room,
                                "number_of_nights": e.price?.number_of_nights,
                                "room_price": e.price?.room_price,
                                "discount": e.price?.discount,
                                "gst": e.price?.gst,
                                "booked_date": e.booked_date,
                                "checking_date": e.checkin_date,
                                "checkout_date": e.checkout_date
                            })
                        }
                    })
                })

                res.status(StatusCode.Sucess).send(bookingHistoryData);

            } else {
                res.status(StatusCode.Sucess).send([])
                res.end()
            }
        } catch (e: any) {
            res.status(StatusCode.Server_Error).send(e.message);
            res.end();
        }
    }

    async bookingFreeze(req: Request, res: Response, cIn: string, cOut: string, roomId: any, hotelId: number) {
        try {
            var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));

            if (roomId.length != 0 && cIn != null && cOut != null && hotelId != 0) {

                //Date converstion
                var cin = new Date(cIn);
                var cout = new Date(cOut);

                //booking request id genteration
                var nextID: any = await bookingmodel.findOne({}, { _id: 1 }).sort({ _id: -1 });

                //number of days count from cin & cout
                var diff = Math.abs(cout.getTime() - cin.getTime());
                var diffDays = Math.ceil(diff / (1000 * 3600 * 24));

                var bookIngData: object = {
                    _id: nextID?._id == undefined ? 1 : Number(nextID?.id) + 1,
                    user_id: reqData.uid,
                    hotel_id: hotelId,
                    no_of_room: roomId.length,
                    room_id: roomId,
                    checkin_date: new Date(cin),
                    checkout_date: new Date(cout),
                    price: {
                        number_of_nights: diffDays,
                        room_price: 0,
                        gst: 0,
                        discount: 0,
                        total_price: 0
                    },
                    status: "pending",
                    paymentId: null,
                    orderId: null
                }

                var bookedData = new bookingmodel(bookIngData);
                await bookedData.save();

                //return id for further delete
                return nextID?._id == undefined ? 1 : Number(nextID?.id) + 1;

            } else {
                return 0;
            }
        } catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();
        }
    }

    //payment fail
    async bookingFreezFail(bookingId: any) {

        await bookingmodel.deleteOne({ $and: [{ _id: bookingId }, { status: "pending" }] });

    }

    //prize confirmation page 
    async getRoomPrize(req: Request, res: Response) {
        try {
            var query: any = req.query;
            var roomid: any = query.roomid.split(",").map(Number);
            var hotelid: any = query.hotelid
            var adults: any = query.adults
            var noOfPersonforRoom = ((roomid.length) * 2);
            var countOfMattress: any = ((adults - noOfPersonforRoom) < 0) ? 0 : (adults - noOfPersonforRoom);

            var getHotelRoom = await hotelmodel.find({ _id: hotelid })
            var hotelId = parseInt(getHotelRoom[0]._id.toString());
            var hotelName = getHotelRoom[0].hotel_name.toString();
            var address = getHotelRoom[0].address?.address_line;
            var rating = parseInt(getHotelRoom[0].rating.toString());
            var roomPrice: any = [];
            var sum = 0;
            var hotelMattress = await hotelmodel.findOne({ _id: hotelid }).select("mattressPrice");

            var hotelMattressPrize = hotelMattress?.mattressPrice ?? 0;
            getHotelRoom.forEach((e: any) => {
                e.room.forEach((d: any) => {
                    if (roomid.includes(d.room_id)) {
                        roomPrice.push(d.price);
                        sum = sum + d.price;
                    }
                })
            })
            var totalMattressPrize = hotelMattressPrize * countOfMattress;
            var checkInDate = new Date(query.cin);
            var checkOutDate = new Date(query.cout);
            var diff = Math.abs(checkOutDate.getTime() - checkInDate.getTime());
            var diffDays = Math.ceil(diff / (1000 * 3600 * 24));
            var getHotelRoomPrice = sum;
            var totalHotelRoomPrize = getHotelRoomPrice + totalMattressPrize;
            var roomPrizwWithDays = totalHotelRoomPrize * diffDays;
            var gstPercentage = 18;
            var discountPercentage;
            var roomPriceWithGst = (roomPrizwWithDays * (gstPercentage / 100));
            if (query.coupon_id != 0) {
                var resCoupon = await couponmodel.find({ "_id": query.coupon_id })
                discountPercentage = Number(resCoupon[0]?.discount);
                var discountPrice:number = (roomPrizwWithDays + roomPriceWithGst) * (discountPercentage / 100)
                if(discountPrice>resCoupon[0].minValue){
                    discountPrice=resCoupon[0].minValue;
                }
            } else {
                discountPercentage = 0;
                discountPrice = 0;
            }
            var totalRoomPrice = (roomPrizwWithDays + roomPriceWithGst - discountPrice);
            var roomPriceData = {
                hotelid: hotelId,
                hotelName: hotelName,
                address: address,
                rating: rating,
                checkInDate: query.cin,
                checkOutDate: query.cout,
                roomId: roomid,
                roomPrice: Math.floor(getHotelRoomPrice),
                noOfmatress: countOfMattress,
                matressPrize: Math.floor(totalMattressPrize),
                noOfDays: diffDays,
                subTotal: Math.floor(roomPrizwWithDays),
                gstPercentage: gstPercentage,
                discountPercentage: discountPercentage,
                gst: Math.floor(roomPriceWithGst),
                offer: Math.floor(discountPrice),
                total: Math.floor(totalRoomPrice)
            }
            res.status(StatusCode.Sucess).send(roomPriceData);
            res.end();

        } catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();
        }
    }

}

export { BookingDomain }