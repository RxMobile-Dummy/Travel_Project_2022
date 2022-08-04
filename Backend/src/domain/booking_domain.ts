import { bookingmodel } from "../model/booking";
import { StatusCode } from "../statuscode";
import { hotelmodel } from "../model/hotel";
import { imagemodel } from "../model/image";
import express, { Express, Request, Response } from 'express'


class BookingDomain {
    async addBooking(req: Request, res: Response) {
        var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));

        try {
            var nextID: any = await bookingmodel.findOne({}, { _id: 1 }).sort({ _id: -1 });
            var noOfRoom: Number = req.body.room_id.length
            var bookIngData: object = {
                _id: nextID?._id == undefined ? 1 : Number(nextID?.id) + 1,
                user_id: reqData.uid,
                hotel_id: req.body.hotel_id,
                no_of_room: noOfRoom,
                room_id: req.body.room_id,
                checkin_date: new Date(req.body.checkin_date),
                checkout_date: new Date(req.body.checkout_date),
                price: {
                    number_of_nights: req.body.price.number_of_nights,
                    room_price: req.body.price.room_price,
                    gst: req.body.price.gst,
                    discount: req.body.price.discount,
                    total_price: req.body.price.total_price
                }
            }
            var sum = 0;
            var rommIdFromReq: any = (req.body.room_id);
            console.log(rommIdFromReq);
            var getHotelRoom = await hotelmodel.find({ _id: req.body.hotel_id })
            var roomPrice: any = [];
            getHotelRoom.forEach((e: any) => {
                e.room.forEach((d: any) => {
                    if (rommIdFromReq.includes(d.room_id)) {
                        roomPrice.push(d.price);
                        sum = sum +d.price;
                    }
                })
            })
            const getHotelRoomPrice: number = sum;
            console.log(getHotelRoom);
            console.log('price ' + getHotelRoomPrice);
            var totalPrize = (req.body.price.total_price);
            var noOfNight = (req.body.price.number_of_nights);
            var roomGstPrice = ((18 / 100) * (getHotelRoomPrice * noOfNight));
            var roomDiscountPrice = ((getHotelRoomPrice * noOfNight) + roomGstPrice) * 0.05;
            console.log(`gst ${roomGstPrice}`);
            console.log(`discount ${roomDiscountPrice}`);
            var roomTotalPrize = ((getHotelRoomPrice * noOfNight) - roomDiscountPrice + roomGstPrice)
            console.log('price ' + roomTotalPrize);
            console.log('total ' + totalPrize);
            if (roomTotalPrize == totalPrize) {
                var bookedData = new bookingmodel(bookIngData);
                console.log(bookedData);
                await bookedData.save();
                res.status(StatusCode.Sucess).send("Booking Success")
                res.end();
            }
            else {
                res.status(StatusCode.Not_Acceptable).send("Error in calculation");
            }
            res.end();
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
            const bookedId: any = [];
            const unAvailableRoomDupId: any = [];
            const unAvailableRoomId: any = [];
            const roomDetailList: any = [];
            var hotelName: any;

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
                console.log(unAvailableBooking);
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
                    console.log(unAvailableRoomId);
                    //get hotel all room Id and subtract it from unAvailable
                    const hRoom = await hotelmodel.find({ _id: hotelId });
                    hRoom.forEach(e => {
                        hotelName = e.hotel_name;
                        e.room.forEach(c => {
                            if (unAvailableRoomId.includes(c.room_id)) {

                            } else {
                                roomDetailList.push(c);
                            }
                        });
                    })
                    console.log(roomDetailList.length)
                    if (roomDetailList.length != 0) {
                        //Room Image query
                        const roomImageData: any = [];
                        await Promise.all(
                            roomDetailList.map(async (e: any) => {
                                let image = await imagemodel.find({ $and: [{ room_id: e.room_id }, { hotel_id: hotelId }] })
                                roomImageData.push({
                                    "room_id": e.room_id,
                                    "room_type": e.room_type,
                                    "room_size": e.room_size,
                                    "bed_size": e.bed_size,
                                    "max_capacity": e.max_capacity,
                                    "price": e.price,
                                    "features": e.features,
                                    "description": e.description,
                                    "image": image
                                }
                                );
                            })

                        );
                        const deluxeList: any = [];
                        const semiDeluxeList: any = [];
                        const superDeluxeList: any = []
                       
                        roomImageData.forEach((e: any) => {
                                if (e.room_type == "Deluxe") {
                                    deluxeList.push(e);
                                } else if (e.room_type == "Semi-Deluxe") {
                                    semiDeluxeList.push(e);
                                } else if (e.room_type == "Super-Deluxe") {
                                    superDeluxeList.push(e);
                                }
                            })
                            var resultData = {
                                "hotel_id": hotelId,
                                "hotel_name": hotelName,
                                "deluxe": deluxeList,
                                "semi-deluxe": semiDeluxeList,
                                "super-deluxe": superDeluxeList,
                            };
                            res.status(StatusCode.Sucess).send(resultData);
                    } else {
                        var resError = {
                            "hotel_id": hotelId,
                            "hotel_name": hotelName,
                            "deluxe": [],
                            "semi-deluxe": [],
                            "super-deluxe": []
                        };
                        res.status(StatusCode.Sucess).send(resError)
                        res.end()
                    }
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
                                "hotel_id": d._id,
                                "hotel_name": d.hotel_name,
                                "address": d.address,
                                'images': d.images,
                                "price": e.price?.total_price,
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
}

export { BookingDomain };