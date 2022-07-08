import { hotelmodel } from "../model/hotel";
import { citymodel } from "../model/city";
import { statemodel } from "../model/state";
import express, { Express, Request, Response } from 'express'


class HotelDomain {

    async getAllHotel(req: Request, res: Response) {
        var gethotelfulldetails = await hotelmodel.find().populate({ path: 'address', 
        populate: { path: 'city_id ', model: citymodel , populate :{model : statemodel , path :'state_id'} }} );
        res.send(gethotelfulldetails);
        res.end();
    }

}

export { HotelDomain };
