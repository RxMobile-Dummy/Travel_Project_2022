import { UserDomain } from '../domain/user_domain'
import express, { Express, Request, Response, Router } from 'express';
var router: Router = express.Router();

class UserController {
    //Post User 
    static async postUser(req: Request, res: Response) {
        const userDomain: UserDomain = new UserDomain();
        await userDomain.postUser(req, res);
    }

    //Update User 
    static async updateUser(req: Request, res: Response) {
        const userDomain: UserDomain = new UserDomain();
        await userDomain.updateUser(req, res);
    }

}

// POST
router.post("/", UserController.postUser);

//PUT
router.put('/', UserController.updateUser);

//EXPORT
export { router };