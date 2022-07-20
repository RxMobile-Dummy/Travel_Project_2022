import { bookmarkmodel } from '../model/bookmark';
import express, { Express, Request, Response } from 'express';
import { hotelmodel } from '../model/hotel';
class BookmarkDomain {
    async postBookmark(req: Request, res: Response) {
        var reqData: any = JSON.parse(JSON.stringify(req.headers['data']));
        var uid: String = reqData.uid;
        var nextID = await bookmarkmodel.findOne({}, { _id: 1 }).sort({ _id: -1 });
        console.log((nextID));
        var postData: object = {
            _id: nextID?._id == undefined ? 1 : Number(nextID?.id) + 1,
            hotel_id:parseInt(req.params.hotel_id),
            user_id:uid
        }
        var data = new bookmarkmodel(postData);
        try {
            await data.save();
            res.send("data added");
        }
        catch (err: any) {
            res.send(err.message);
        }
        res.end();

    }

    async deleteBookmark(req: Request, res: Response) {
        console.log('delete');
        await bookmarkmodel.deleteOne({$and:[{hotel_id:parseInt(req.params.hotel_id)},{user_id:1}]}).then(()=>{
            console.log('Deleted');
            res.send('deleted');
        })
    }
}
export { BookmarkDomain };