import express, { Express, Request, Response } from 'express';
import mongoose from 'mongoose';
import * as dotenv from 'dotenv';
import { verifyToken, checkRequest } from "./authentication/verify_token";
import * as admin from 'firebase-admin';
import credential from "./travelproject22-6b9d4-firebase-adminsdk-2wiay-c9c1876710.json";
import { LoggerMiddleware } from './middlewear/logger';
import { bookingmodel } from './model/booking';
import cors from "cors";

import * as firebase from 'firebase/app';
import { firebaseConfig } from "./firebase.config";
firebase.initializeApp(firebaseConfig);




const app: Express = express();
const connection = mongoose.connect('mongodb+srv://akash:akash@cluster0.4gzjhma.mongodb.net/mmt');
dotenv.config();
const port = process.env.PORT;
var corsOptions = {
    origin: '*',
    optionsSuccessStatus: 200 // some legacy browsers (IE11, various SmartTVs) choke on 204

}

app.use(cors(corsOptions));
app.use(express.json());


app.use(LoggerMiddleware);


// ROUTER
import { router as hotelroute } from './controller/hotel_controller';
import { router as tourroute } from './controller/tour_controller';
import { router as cityroute } from './controller/city_controller';
import { router as Roomrouter } from './controller/room_controller';
import { router as UserRouter } from './controller/user_controller';
import { router as reviewroute } from './controller/review_controller';
import { router as bookingroute } from './controller/booking_controller';
import { router as bookmarkroute } from './controller/bookmark_controller';
import { router as cancelbookingroute } from './controller/cancel_booking_controller';
import { router as paymentroute } from './controller/payment_controller';
import {router as deviceroute} from './controller/device_controller';
import { router as couponroute } from './controller/coupon_controller';
import { router as webhookroute } from './controller/webhook_controller';
import { router as pushnotificationadminroute} from './controller/push_notification_admin_controller';



// FIREBASE INTITIALIZE
admin.initializeApp(
    {
        credential: admin.credential.cert(JSON.parse(JSON.stringify(credential)))
    }
);
app.use('/webhook',webhookroute );

// TOKEN VERIFICATION CALL
app.use(verifyToken, checkRequest);

// ROOT LEVEL
app.get('/', (req: Request, res: Response) => {
    res.send('MMT Backend development');
    res.end();
});

// USE
app.use('/hotel', hotelroute);
app.use('/room', Roomrouter);
app.use('/tour', tourroute);
app.use('/city', cityroute);
app.use('/user', UserRouter)
app.use('/review', reviewroute);
app.use('/booking', bookingroute);
app.use('/bookmark', bookmarkroute);
app.use('/cancelBooking', cancelbookingroute);
app.use('/coupon', couponroute);
app.use('/payment', paymentroute);
app.use('/device',deviceroute);
app.use('/broadcast',pushnotificationadminroute);




// LISTEN
app.listen(port, () => {
    console.log(`⚡️[server]: Server is running at ${port}`);
});
