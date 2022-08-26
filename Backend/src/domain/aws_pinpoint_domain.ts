import { Request, Response } from 'express';
import { StatusCode } from "../statuscode"
import Amplify, { Auth, Analytics, AWSPinpointProvider } from 'aws-amplify';
import { Usermodel } from '../model/users';
import { hotelmodel } from '../model/hotel';

class AwsPinpoinntDomain {
    async addToWhishList(req: Request, res: Response) {
        try {
            var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
            var uid: string = reqData.uid;
            var userData = await Usermodel.findById(uid);
            var hotelData = await hotelmodel.findById(req.params.hotelid);

           var test =  await Analytics.updateEndpoint({
                address: userData?.user_email.toString(),
                Attributes: { whishlist: ["whishlist"], booked: ['No'] },
                channelType: 'EMAIL',
                optOut: 'NONE',
                
                userAttributes: {
                    username: [userData?.user_name.toString()],
                    userId: [userData?._id.toString()],
                    hotelName: [hotelData?.hotel_name.toString()]
                }});
            console.log(userData?.user_email.toString());
            
        
            var test2 = await Analytics.record({ name: 'AddToWhishlist' }).then(()=>{console.log("event event recorded");
            })
            // console.log(test2);
            // console.log(test2.EventsResponse.Results);
            
            res.status(StatusCode.Sucess).send("event recorded");

        } catch (error: any) {
            console.log(error);
            
            res.status(StatusCode.Server_Error).send(error);
        }
    }

    async madeBooking(req: Request, res: Response) {
        try {
            var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
            var uid: string = reqData.uid;
            var userData = await Usermodel.findById(uid);
            var hotelData = await hotelmodel.findById(req.params.hotelid);

            await Analytics.updateEndpoint({
                address: userData?.user_email.toString(),
                Attributes: { whishlist: ["whishlist"], booked: ['Yes'] },
                channelType: 'EMAIL',
                optOut: 'NONE',
                userAttributes: {
                    username: [userData?.user_name.toString()],
                    userId: [userData?._id.toString()],
                    hotelName: [hotelData?.hotel_name.toString()]
                }
            });

            await Analytics.record({ name: 'MadeBooking' })
            res.status(StatusCode.Sucess).send("event recorded");;
        } catch (error: any) {
            res.status(StatusCode.Server_Error).send(error);
        }
    }
}

export { AwsPinpoinntDomain }