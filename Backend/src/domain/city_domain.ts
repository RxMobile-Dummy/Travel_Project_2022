import { citymodel } from "../model/city";
import { StatusCode } from "../statuscode";
import express, { Express, Request, Response } from 'express'

class CityDomain {
    async getAllCity(req: Request, res: Response) {
        try {
            citymodel.find({}, function (error: Error, result: String) {
                if (result) {
                    res.status(StatusCode.Sucess).send(result);

                    res.end();
                } else {
                    res.status(StatusCode.Server_Error).send(error);
                    res.end();
                }
                res.end();
            }).select('_id city_name')
        }
        catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
            res.end();

        }
    }
}

export { CityDomain };