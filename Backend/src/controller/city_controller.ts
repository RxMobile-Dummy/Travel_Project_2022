import { CityDomain } from "../domain/city_domain";
import express, { Express, Request, Response } from 'express';
var router = express.Router();

class CityController {
    static async getAllcity(req:Request , res:Response){
        const citydomain = new CityDomain();
        citydomain.getAllCity(req,res)
    }
}

router.get('/',CityController.getAllcity);
export{router}