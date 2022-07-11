import { citymodel } from "../model/city";
import express, { Express, Request, Response } from 'express'

class CityDomain{
    async getAllCity(req: Request , res: Response){
        try{
            citymodel.find({}, function (error:Error, result:String) {
                if(result){
                res.send(result);
               
                res.end();
                }else {
                    res.send(error);
                    res.end();
                }
                res.end();
              }).select('_id city_name')
        }
        catch (err: any) {
            res.status(500).send(err.message);
            res.end();

        }
    }
}

export {CityDomain};