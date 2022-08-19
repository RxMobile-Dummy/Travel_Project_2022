import { devicemodel } from "../model/device";
import express, { Express, Request, Response } from 'express'
import { StatusCode } from "../statuscode";

class DeviceDomain {
    async adddevice(req: Request, res: Response) {
        var nextID: any = await devicemodel.findOne({}, { _id: 1 }).sort({ _id: -1 });
        var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
        var devicedata = {
            _id: nextID?._id == undefined ? 1 : Number(nextID?.id) + 1,
            device_id: req.body.deviceid,
            useruid: reqData.uid,

            fcmtoken: req.body.fcmtoken,
            devicetype: req.body.devicetype,
        }
        var deviceid = await devicemodel.find({ device_id: req.body.deviceid })
        var data = new devicemodel(devicedata);
        try {
            if (deviceid.length == 1) {
                await devicemodel.updateOne({
                    "device_id": req.body.deviceid,

                },
                    {
                        $set: {
                            useruid: reqData.uid,
                            fcmtoken: req.body.fcmtoken
                        }
                    }
                );
                res.status(StatusCode.Sucess).send("data updated")
            }
            else {
                await data.save();
                res.status(StatusCode.Sucess).send("Data save")
            }

        }
        catch (err: any) {
            res.status(StatusCode.Server_Error).send(err.message);
        }

    }

    async deletedevice(req: Request, res: Response) {
        console.log(req.params.deviceid)
        await devicemodel.deleteOne({ device_id: req.params.deviceid }).then(function () {
            console.log("Data deleted");
            res.status(StatusCode.Sucess).send("Data deleted") // Success
            res.end();
        }).catch(function (error) {
            console.log(error); // Failure
            res.status(StatusCode.Server_Error).send(error.message);
            res.end();
        });
    }


    async refreshFCM(req: Request, res: Response) {
        console.log("hy");
        console.log(req.query);
        console.log(req.query.deviceid);
        var deviceId = await devicemodel.find({ device_id: req.query.deviceid });
        if (deviceId.length == 1) {
            await devicemodel.updateOne({
                "device_id": req.query.deviceid,
            },
                {
                    $set: {

                        fcmtoken: req.query.fcmtoken
                    }
                }
            );
            res.status(StatusCode.Sucess).send("update fcm");
        } else {
            console.log("not updae")
            res.status(StatusCode.Sucess).send("not update");

        }
    }




}

export { DeviceDomain };