import express, { Express, Request, Response } from 'express';
import * as admin from 'firebase-admin';
import { devicemodel } from '../model/device';
const notification_options = {

    priority: "high",

    timeToLive: 60 * 60 * 24

};


class PushNotificationAdminDomain {

    async PushNotificationAdminBroadCast(req: Request, res: Response) {
        console.log(req.body.message);
        const message = [{

            "notification": {

                "title": req.body.title,

                "body": req.body.body

            }, "android": {

                "notification": {

                    "imageUrl": req.body.imageUrl,

                    "sound": "default"

                }

            },

            "topic": "Events"

        }];


        const options = notification_options



        admin.messaging().sendAll(message, false)

            .then(response => {



                res.status(200).send("Notification sent successfully to registered User")
              


            })

            .catch(error => {

                console.log(error);

            });
    }
    async PushNotificationAdminEndUser(req: Request, res: Response) {
        console.log("end User");
        const message = {

            "notification": {

                "title": req.body.title,
                "body": req.body.body,
                "image": req.body.imageUrl,
                "sound": "default"

            },

        };


        var userDevices = await devicemodel.find({});

        var registrationToken: any = [];

        userDevices.forEach(element => {

            registrationToken.push(element.fcmtoken);

        });



        admin.messaging().sendToDevice(registrationToken, message, notification_options).then(
            response => {
                res.status(200).send("Notification sent successfully to end users")
               
            }
        ).catch(error => {

            console.log(error);

        });
    }
}
export { PushNotificationAdminDomain };