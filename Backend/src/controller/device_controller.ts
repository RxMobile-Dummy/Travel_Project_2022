import { DeviceDomain } from "../domain/device_domain";
import express, { Express, Request, Response } from 'express';
var router = express.Router();

class DeviceController {
    static async addDevice(req: Request, res: Response) {
        const devicedomain = new DeviceDomain();
        await devicedomain.adddevice(req, res);
    }

    static async deleteDevice(req: Request, res: Response) {
        const devicedomain = new DeviceDomain();
        await devicedomain.deletedevice(req, res);
    }


    static async refreshFCM(req: Request, res: Response) {
        const devicedomain = new DeviceDomain();
        await devicedomain.refreshFCM(req, res);
    }

}

router.post('/',DeviceController.addDevice);
router.delete('/:deviceid',DeviceController.deleteDevice);
router.get('/updatefcm',DeviceController.refreshFCM);
export { router };