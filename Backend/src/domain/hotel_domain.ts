import { hotelmodel } from "../model/hotel";
import { citymodel } from "../model/city";
import { statemodel } from "../model/state";
import { imagemodel } from "../model/image";
import express, { Express, Request, Response } from 'express'


class HotelDomain {

    async getAllHotel(req: Request, res: Response) {
        var gethotelfulldetails = await hotelmodel.find().populate({
            path: 'address',
            populate: { path: 'city_id ', model: citymodel, populate: { model: statemodel, path: 'state_id' } }
        });
        res.send(gethotelfulldetails);
        res.end();
    }


    //get hotel image based on ui send limit of needed image
    async getHotelImage(req: Request, res: Response) {
        try {
            var imageData = await imagemodel.find({ room_id: null }).limit(parseInt(req.params.imagelimit));
            
            if(imageData){
                res.status(200).send(imageData);
            }else{
                res.status(404).send("can't find Image");
            }

            res.end();
        } catch (e:any) {
            res.status(500).send(e.message);
            res.end();
        }
    }
}

export { HotelDomain };
