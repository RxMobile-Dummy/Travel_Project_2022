import { Request, Response } from 'express';
import { bookingmodel } from '../model/booking';
import { StatusCode } from '../statuscode';
import * as admin from 'firebase-admin';
import schedule from 'node-schedule';

class CancelBookingDomain {
    async cancelBooking(req: Request, res: Response) {
        try {
            //Production 
            var currentDate = new Date().toISOString();

            //testing
            //var currentDate = new Date("2022-07-29T00:00:00.000+00:00");
            //console.log(currentDate);

            var bookingId: Number = Number(req.params.bookingid);
            var checkBookingData: object | null = await bookingmodel.findById(bookingId);

            if (checkBookingData == null) {
                res.status(StatusCode.Bad_Request).send("invalid booking id");
            }
            else {
                var bookingData: object | null | any = await bookingmodel.findOne({ $and: [{ _id: bookingId }, { checkin_date: { $gt: currentDate } }] });
                if (bookingData == null) {
                    res.status(StatusCode.Gone).send("can't cancel hotel bacause your check in date is started...");
                }
                else {
                    //change status in booking table
                    var cancelStatus: object = {
                        status: "cancel"
                    }
                    await bookingmodel.findByIdAndUpdate(bookingId, cancelStatus);

                    //For calculate hours difference between check in date and current date
                    var temp: any = await bookingmodel.aggregate([
                        {
                            $lookup: {
                                from: "users",
                                localField: "user_id",
                                foreignField: "_id",
                                as: "user_data",
                            },
                        }, {
                            $lookup: {
                                from: "hotels",
                                localField: "hotel_id",
                                foreignField: "_id",
                                as: "hotel_data",
                            }
                        },
                        {

                            $set: {
                                hoursDiff: {
                                    $dateDiff: {
                                        startDate: { $toDate: currentDate },
                                        endDate: { $toDate: bookingData?.checkin_date },
                                        unit: "hour"
                                    }
                                }
                            }
                        },
                        { $match: { hoursDiff: { $gt: 0 }, "_id": bookingId } },



                    ]);

                    //Production 
                    var hoursDifference: Number = Number(temp[0].hoursDiff);

                    //testing
                    //var hoursDifference = 23;
                    var paymentPrice = Number(temp[0].price.total_price);
                    var refundAmmount: Number;

                    if (hoursDifference >= 72) {
                        refundAmmount = paymentPrice;
                        console.log("free");

                    }
                    else if (hoursDifference >= 48) {
                        console.log("20% charge");
                        console.log("80% will refund");
                        refundAmmount = paymentPrice * 0.8


                    }
                    else if (hoursDifference >= 24) {
                        console.log("50% charge");
                        console.log("50% will refund");

                        refundAmmount = paymentPrice * 0.5

                    }
                    else {
                        console.log("100% charge");
                        console.log("0% will refund");
                        refundAmmount = paymentPrice * 0
                    }

                    // ****************************** FOR NOTIFICATION ****************************** //
                    const notification_options = {
                        priority: "high",
                        timeToLive: 60 * 60 * 24
                    };
                    const registrationToken = req.params.deviceid
                    const options = notification_options
                    const message = {
                        "data": {"key" : "booking"},
                        "notification": {
                            "title": "Booking Cancelled successfully",
                            "body": `Dear ${temp[0].user_data[0].user_name} ,refund ammount is ₹${refundAmmount} for your booking of ${temp[0].hotel_data[0].hotel_name} as per our booking cancellation policy`
                        }
                    }

                    // Booking Cancelled Notification
                    admin.messaging().sendToDevice(registrationToken, message, options)

                    // Delete scheduled notification 
                    var job1 = schedule.scheduledJobs[`${bookingId}1`];
                    var job2 = schedule.scheduledJobs[`${bookingId}2`];
                    var job3 = schedule.scheduledJobs[`${bookingId}3`];
                    
                    if(job1 != undefined)
                    {
                        job1.cancel();
                    }
                    if(job2 != undefined)
                    {
                        job2.cancel();
                    }
                    if(job3 != undefined)
                    {
                        job3.cancel();
                    }
   
                    res.status(StatusCode.Sucess).send("booking cancelled")
                }
            }

        } catch (error: any) {
            res.status(StatusCode.Server_Error).send(error);
        }
    }
}

//Export 
export { CancelBookingDomain }