import express, { Express, Request, Response } from 'express';
const app: Express = express();
import mongoose from 'mongoose';
const connection = mongoose.connect('mongodb://localhost:27017/mmtdata');
import { router as hotelroute} from  './controller/hotel_controller';
import { router as tourroute} from  './controller/tour_controller';
import { router as cityroute } from './controller/city_controller';
import { router as bookingroute } from './controller/booking_controller';
import { verifyToken,checkRequest } from "./authentication/verify_token";
import * as admin from 'firebase-admin';
import credential from "./travelproject22-6b9d4-firebase-adminsdk-2wiay-c9c1876710.json";
import * as dotenv from 'dotenv';
import { Roomrouter } from './controller/room_controller';

dotenv.config();
const port = process.env.PORT;
app.use(express.json());
//firebase intitialize 
admin.initializeApp(
    {
        credential: admin.credential.cert(JSON.parse(JSON.stringify(credential)))
    }
);
//Token verification call
app.use(verifyToken,checkRequest);

app.use('/hotel',hotelroute);
app.use('/room' ,Roomrouter);
app.use('/tour',tourroute);
app.use('/city',cityroute);
app.use('/booking',bookingroute);

app.get('/', (req: Request, res: Response) => {
    res.send('MMT Backend development');
    res.end();
});
app.listen(port, () => {
    console.log(`⚡️[server]: Server is running at ${port}`);
});
