import { hotelmodel } from '../model/hotel';
import express, { Express, Request, Response } from 'express';
import { imagemodel } from '../model/image'
import { StatusCode } from '../statuscode'


class RoomDomain {

    // commen function 
    async getRoomWithType(req: Request, res: Response, roomtype: String) {
        var hotelId: Number = Number(req.params.id);

        try {
            var data: any = await hotelmodel.findOne({ _id: hotelId }, { _id: 1, hotel_name: 1, room: 1 });
            var roomData: any = await data?.room.find((o: any) => String(o.room_type) === roomtype);
            var imageData: object | null = await imagemodel.find({ $and: [{ room_id: roomData?.room_id }, { hotel_id: hotelId }] });
            if (data == null) {
                res.status(StatusCode.Not_Found).send("can't find hotel on this id");
            }
            else {
                if (roomData == null) {
                    roomData = [];
                    imageData = [];
                }
                var responseJson: object = {
                    hotel_id: data._id,
                    hotel_name: data?.hotel_name,
                    room_data: roomData,
                    room_image: imageData
                }

                res.status(StatusCode.Sucess).send(responseJson);
            }

        }

        catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
        }

    }

    // commen function 
    newJson(roomData: any, imageData: Object) {
        var tempNewJson: Object = {
            "room_id": roomData?.room_id,
            "room_type": roomData?.room_type,
            "room_size": roomData?.room_size,
            "bed_size": roomData?.bed_size,
            "max_capacity": roomData?.max_capacity,
            "price": roomData?.price,
            "features": roomData?.features,
            "description": roomData?.description,
            "images": imageData
        }
        return tempNewJson;
    }


    // Get Room with Deluxe Type 
    async getRoomWithDeluxeType(req: Request, res: Response) {
        await this.getRoomWithType(req, res, "Deluxe");
    }

    // Get Room with Semi-Deluxe Type 
    async getRoomWithSemiDeluxeType(req: Request, res: Response) {
        await this.getRoomWithType(req, res, "Semi-Deluxe");

    }

    // Get Room with Super-Deluxe Type 
    async getRoomWithSuperDeluxeType(req: Request, res: Response) {
        await this.getRoomWithType(req, res, "Super-Deluxe")

    }

    // Get All Available Room
    async getAllAvailableRoom(req: Request, res: Response) {
        var hotelid: Number = Number(req.params.id);

        try {
            var data: any = await hotelmodel.findOne({ _id: hotelid }, { _id: 1, hotel_name: 1, room: 1 });

            var roomData = [];

            var deluxeRoomdata: any = await data?.room.find((o: any) => String(o.room_type) === "Deluxe");
            var deluxeImagedata: object | null = await imagemodel.find({ $and: [{ room_id: deluxeRoomdata?.room_id }, { hotel_id: hotelid }] });

            if (deluxeRoomdata != null) {
                var newDeluxeJson = this.newJson(deluxeRoomdata, deluxeImagedata);
                roomData.push(newDeluxeJson);
            }

            var semiDeluxeRoomdata: any = await data?.room.find((o: any) => String(o.room_type) === "Semi-Deluxe");
            var semiDeluxeImagedata: object | null = await imagemodel.find({ $and: [{ room_id: semiDeluxeRoomdata?.room_id }, { hotel_id: hotelid }] });

            if (semiDeluxeRoomdata != null) {
                var newSemiDeluxeJson = this.newJson(semiDeluxeRoomdata, semiDeluxeImagedata);
                roomData.push(newSemiDeluxeJson);
            }

            var superDeluxeRoomdata: any = await data?.room.find((o: any) => String(o.room_type) === "Super-Deluxe");
            var superDeluxeImagedata: object | null = await imagemodel.find({ $and: [{ room_id: superDeluxeRoomdata?.room_id }, { hotel_id: hotelid }] });

            if (superDeluxeRoomdata != null) {
                var newSuperDeluxeJson = this.newJson(superDeluxeRoomdata, superDeluxeImagedata);
                roomData.push(newSuperDeluxeJson);

            }

            if (data == null) {
                res.status(StatusCode.Not_Found).send("can't find hotel on this id");
            }
            else {
                if (roomData == null) {
                    roomData = [];
                }
                var responseJson: object = {
                    hotel_id: data._id,
                    hotel_name: data?.hotel_name,
                    room_data: roomData,
                }

                res.status(StatusCode.Sucess).send(responseJson);
            }

        }

        catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
        }

    }

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
                            image: roomImageData
                        }
                    });
                });
                if (resData != null) {
                    res.status(StatusCode.Sucess).send(resData);
                } else {
                    res.status(StatusCode.Not_Found).send('Data Not Found');
                    res.end();
                }
            } else {
                res.status(StatusCode.Not_Found).send('Data Not Found');
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