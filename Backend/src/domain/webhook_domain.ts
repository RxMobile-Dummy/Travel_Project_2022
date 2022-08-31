import express, { Express, Request, Response } from 'express';
import { bookingmodel } from '../model/booking';
import { devicemodel } from '../model/device';
import { hotelmodel } from '../model/hotel';
import { Usermodel } from '../model/users';
import * as admin from 'firebase-admin';
import schedule from 'node-schedule';
import { StatusCode } from '../statuscode';

var secret = process.env.SECRET;
class WebhookDomain {

    async verifyPayment(req: Request, res: Response) {
        const SECRET = process.env.SECRET;

        try {
            if (req.body.payload.payment.entity.status == "captured") {

                console.log(req.body.payload.payment.entity.status);
                console.log(req.body.payload.payment.entity.order_id);
                var paymentstatus: any = await bookingmodel.findOne({ $and: [{ "orderId": req.body.payload.payment.entity.order_id }, { status: "pending" }] });
                console.log(paymentstatus);

                if (paymentstatus != null) {

                    await bookingmodel.updateOne(
                        {
                            "orderId": req.body.payload.payment.entity.order_id,

                        },
                        {
                            $set: {
                                status: "success",
                                paymentId: req.body.payload.payment.entity.id
                            }
                        },
                    );

                    // ****************************** FOR NOTIFICATION ****************************** //
                    var requiredData: any = await bookingmodel.findOne({ "orderId": req.body.payload.payment.entity.order_id, }).populate('user_id');

                    const notificationId = requiredData?._id
                    const notification_options = {
                        priority: "high",
                        timeToLive: 60 * 60 * 24
                    };

                    // To find FCM token
                    var userDevices = await devicemodel.find({ useruid: requiredData?.user_id._id });
                    var registrationToken: any = [];
                    userDevices.forEach(element => {
                        registrationToken.push(element.fcmtoken);
                    });

                    const options = notification_options
                    var userData: String = requiredData?.user_id.user_name
                    var hotelData: String = requiredData?.hotel_id.hotel_name
                    var checkinDate = requiredData?.checkin_date
                    var checkoutDate = requiredData?.checkout_date

                    const bookingSuccessfullMessage = {
                        "data": { "key": "booking" },
                        "notification": {
                            "title": "Booking successfull",
                            "body": `Hi ${userData}, thanks for choosing to stay at ${hotelData}`
                        }

                    }
                    const before24hrsmessage = {
                        "data": { "key": "booking" },
                        "notification": {
                            "title": "24 hours remaining",
                            "body": `Hi ${userData}, 24 hours remaining of your booking at ${hotelData}`
                        }
                    }
                    const before1hrmessage = {
                        "data": { "key": "booking" },
                        "notification": {
                            "title": "1 hours remaining",
                            "body": `Hi ${userData}, only 1 hour remaining of your booking at ${hotelData}`
                        }
                    }
                    const after1hrmessage = {
                        "data": { "key": "booking" },
                        "notification": {
                            "title": "Review",
                            "body": `Hi ${userData}, thanks for choosing to stay at ${hotelData} please give your feedback`
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
                    res.status(StatusCode.Sucess).send("done");
                    res.end();
                }
            }
            else {
                res.status(StatusCode.Bad_Request).send("fail");
                res.end();
            }
        }
        catch (error:any) {
            res.status(StatusCode.Server_Error).send(error.message);
        }

    }
}


export { WebhookDomain };