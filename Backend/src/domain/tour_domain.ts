import { tourmodel } from "../model/tour";
import { imagemodel } from "../model/image";

import express, { Express, Request, Response } from 'express';

class TourDomain {

    //get tour based on ui send limit of needed data
    async getTour(req: Request, res: Response) {
        try {
            var tourData = await tourmodel.aggregate([
                {
                    $lookup: {
                        from: 'images',
                        localField: '_id',
                        foreignField: 'tour_id',
                        as: 'images'
                    }
                }
            ]).limit(parseInt(req.params.tourlimit));
            if(tourData.length!=0){
                res.status(200).send(tourData);
            }else{
                res.status(404).send("can't find Tour Data");
            }
            res.end();
        } catch (e:any) {
            res.status(500).send(e.message);
            res.end();
        }
    }


}

//export domain class
export { TourDomain };