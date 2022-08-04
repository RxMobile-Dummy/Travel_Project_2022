import { citymodel } from "../model/city";
import { StatusCode } from "../statuscode";
import { hotelmodel } from "../model/hotel";
import { statemodel } from "../model/state";
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


    async getcityList(req: Request, res: Response) {
        var q: any = req.query;
        var city: String = q.searchdata;
        if (city.length == 0) {
            res.status(StatusCode.Sucess).send([]);
            res.end();
        } else {
            try {
                var cityData = await citymodel.find({ city_name: { $regex: `^${city}`, $options: 'i' } }).populate({ path: 'state_id', model: statemodel });
                
                var hotelData = await hotelmodel.find({
                    $or: [
                        { "address.address_line": { $regex: city + '.*', $options: 'i' } },
                        { hotel_name: { $regex: city + '.*', $options: 'i' } }]
                }).select("hotel_name");

                var resList: any = [];
                
                cityData.forEach((e:any) => {
                    var state: any = e.state_id;
                    var resData = {
                        id: parseInt(e.id),
                        'name': e.city_name + ', ' + state.state_name,
                        'type': 'area'
                    }
                    resList.push(resData);
                });
                hotelData.forEach((e:any) => {
                    var resData = {
                        id: parseInt(e.id),
                        'name': e.hotel_name,
                        'type': 'hotel'
                    }
                    resList.push(resData);
                })

                res.status(StatusCode.Sucess).send(resList);
                res.end();
            }
            catch (err: any) {
                res.status(StatusCode.Server_Error).send(err.message);
                res.end();

            }
        }
    }
}

export { CityDomain };