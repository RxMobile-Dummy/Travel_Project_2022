import { bookingmodel } from "../model/booking";
import { StatusCode } from "../statuscode";
import { hotelmodel } from "../model/hotel";
import express, { Express, Request, Response } from 'express'


class BookingDomain {
    async addBooking(req: Request, res: Response) {
        var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
        var uid: string = reqData.uid;
        try {
            var nextID: any = await bookingmodel.findOne({}, { _id: 1 }).sort({ _id: -1 });
            var noOfRoom: Number = req.body.room_id.length
            var bookIngData: object = {
                _id: nextID?._id == undefined ? 1 : Number(nextID?.id) + 1,
                user_id: uid,
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

            var rommIdFromReq: Number = (req.body.room_id);
            var getHotelRoom = await hotelmodel.findOne({ _id: req.body.hotel_id }).select({ room: { $elemMatch: { room_id: rommIdFromReq } } });
            const getHotelRoomPrice: any = getHotelRoom?.room[0].price;
            console.log(getHotelRoomPrice)
            var totalPrize = (req.body.price.total_price);
            var noOfNight = (req.body.price.number_of_nights);
            var roomDiscount = (req.body.price.discount);
            var roomGst = (req.body.price.gst);
            var roomDiscountPrice = ((roomDiscount / 100) * (getHotelRoomPrice * noOfNight));
            var roomGstPrice = ((roomGst / 100) * (getHotelRoomPrice * noOfNight));
            var roomTotalPrize = ((getHotelRoomPrice * noOfNight) - roomDiscountPrice + roomGstPrice)

            if (roomTotalPrize == totalPrize) {
                var bookedData = new bookingmodel(bookIngData);
                await bookedData.save();
                res.status(StatusCode.Sucess).send("you sucessfully book")
            }
            else {
                res.status(StatusCode.Not_Acceptable).send("error in calculation");
            }
            res.end();
        } catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();

        }
    }
}

export { BookingDomain };