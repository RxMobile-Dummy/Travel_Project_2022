import express, { Express, Request, Response, Router } from 'express';
import { PushNotificationAdminDomain } from '../domain/push_notification_admin_domain';
var router: Router = express.Router();

class PushNotificationController{
 static async PushNotificationAdminBroadCast(req: Request, res: Response) {
        const pushNotificationAdminDomain:PushNotificationAdminDomain= new PushNotificationAdminDomain();
        await pushNotificationAdminDomain.PushNotificationAdminBroadCast(req, res);
    }
    static async PushNotificationAdminEndUser(req:Request,res:Response){
        const pushNotificationAdminDomain:PushNotificationAdminDomain = new PushNotificationAdminDomain();
        await pushNotificationAdminDomain.PushNotificationAdminEndUser(req,res);
    }
}

router.post("/registered", PushNotificationController.PushNotificationAdminBroadCast);
router.post("/endUser",PushNotificationController.PushNotificationAdminEndUser);

//EXPORT
export { router };