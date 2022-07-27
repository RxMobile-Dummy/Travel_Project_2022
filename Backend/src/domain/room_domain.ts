import { hotelmodel } from '../model/hotel';
import express, { Express, Request, Response } from 'express';
import { imagemodel } from '../model/image'
import { StatusCode } from '../statuscode'


class RoomDomain {

    async getPerticularRoom(req: Request, res: Response) {
        try {
            var roomData = await hotelmodel.find({ _id: req.params.hotelid }).select({ room: { $elemMatch: { room_id: req.params.roomid } }, "hotel_name": 1 });
            var roomImageData = await imagemodel.find({ $and: [{ room_id: req.params.roomid }, { hotel_id: req.params.hotelid }] });
            var resData: any;
            if (roomData != null) {
                roomData.forEach(e => {
                    e.room.forEach(d => {
                        resData = {
                            hotel_id: e._id,
                            hotel_name: e.hotel_name,
                            room_id: d.room_id,
                            room_type: d.room_type,
                            room_size: d.room_size,
                            bed_size: d.bed_size,
                            max_capacity: d.max_capacity,
                            price: d.price,
                            features: d.features,
                            description: d.description,
                            images: roomImageData
                        }
                    });
                });
                if (resData != null) {
                    res.status(StatusCode.Sucess).send(resData);
                } else {
                    res.status(StatusCode.Sucess).send('Data Not Found');
                    res.end();
                }
            } else {
                res.status(StatusCode.Sucess).send('Data Not Found');
                res.end();
            }
        } catch (e: any) {
            res.status(StatusCode.Server_Error).send(e.message);
            res.end();
        }
    }
}

//EXPORT
export { RoomDomain };