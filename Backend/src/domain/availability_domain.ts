import { bookingmodel } from "../model/booking";
import { StatusCode } from "../statuscode";
import { hotelmodel } from "../model/hotel";

class AvailabilityDomain{

    async checkAvailability(cIn: any, cOut: any, hotelId: any, noOfRoom: any) {
        const bookedId: any = [];
        const unAvailableRoomDupId: any = [];
        const unAvailableRoomId: any = [];
        const roomDetailList: any = [];

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

            if (unAvailableBooking != null) {

                //Available roomId 
                unAvailableBooking.forEach((e:any) => {
                    e.room_id.forEach((d:any) => {
                        if (!unAvailableRoomId.includes(d)) {
                            unAvailableRoomId.push(d);
                        }
                    })
                })

                //get hotel all room Id and subtract it from unAvailable
                const hRoom = await hotelmodel.find({ _id: hotelId });
                hRoom.forEach(e => {
                    e.room.forEach(c => {
                        if (!unAvailableRoomId.includes(c.room_id)) {
                            roomDetailList.push(c);
                        }
                    });
                })
                
                if (roomDetailList.length >= noOfRoom) {
                    return hotelId;
                }
            }
        }
    }

}

export { AvailabilityDomain };