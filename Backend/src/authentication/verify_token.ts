import * as admin from 'firebase-admin';
import { StatusCode } from '../statuscode'

//verifyToken method
function verifyToken(req: any, res: any, next: any) {
    try {
        let resData: any;
        let token: any = req.headers['token'];

        //verify token
        admin.auth().verifyIdToken(token).then((decodedToken) => {

            resData = {
                "uid": decodedToken.user_id,
                "email": decodedToken.email,
                "provider": decodedToken.firebase.sign_in_provider
            }
            //header store for further post useage
            req.headers["data"] = resData;
            next();
        }
        ).catch((error) => {
            return res.status(StatusCode.Unauthorized).json({
                errorMessage: error.message,
                expired: error.expired,
                message: 'Unauthorized Access'
            });
        });

    } catch (error: any) {
        return res.status(StatusCode.Unauthorized).json({
            errorMessage: error.message,
            message: 'Unauthorized Access'
        });

    }
}


//check request method
function checkRequest(req: any, res: any, next: any) {

    let headerData = JSON.parse(JSON.stringify(req.headers["data"]));
    let method = req.method;

    //authorization logic
    switch (method) {
        case "GET": {
            next();
            break;
        }
        case "POST": {
            if (headerData.email == null || headerData.provider == "anonymous") {
                return res.status(StatusCode.Unauthorized).json({
                    message: 'Anonymous User Try to access POST request.. Unauthorized Access'
                });
            } else {
                next();
            }
            break;
        }
        case "DELETE": {
            if (headerData.email == null || headerData.provider == "anonymous") {
                return res.status(StatusCode.Unauthorized).json({
                    message: 'Anonymous User Try to access DELETE request.. Unauthorized Access'
                });
            } else {
                next();
            }
            break;
        }
        case "PUT": {
            if (headerData.email == null || headerData.provider == "anonymous") {
                return res.status(StatusCode.Unauthorized).json({
                    message: 'Anonymous User Try to access PUT request.. Unauthorized Access'
                });
            } else {
                next();
            }
            break;
        }
        default: {
            return res.status(StatusCode.Unauthorized).json({
                message: 'Unauthorized Access'
            });
        }
    }
}

export { verifyToken, checkRequest }