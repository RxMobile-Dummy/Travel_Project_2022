import express, { Express, Request, Response } from 'express';
const app: Express = express();
import mongoose from 'mongoose';
const connection = mongoose.connect('mongodb://localhost:27017/mmtdata');
import { router as hotelroute} from  './controller/hotel_controller';
import { router as tourroute} from  './controller/tour_controller';
import { router as cityroute } from './controller/city_controller';
import * as dotenv from 'dotenv';
dotenv.config();
const port = process.env.PORT;
app.use(express.json());




//tour route
app.use('/tour',tourroute)

app.use('/hotel',hotelroute);
app.use('/city',cityroute);
app.get('/', (req: Request, res: Response) => {
    res.send('MMT Backend development');
    res.end();
});
app.listen(port, () => {
    console.log(`⚡️[server]: Server is running at ${port}`);
});
