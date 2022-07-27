import { BookmarkDomain } from '../domain/bookmark_domain';
import express, { Express, Request, Response } from 'express';
var router = express.Router();

class BookmarkController {
    static async postBookmark(req: Request, res: Response) {
        const bookmarkdomain = new BookmarkDomain();
        await bookmarkdomain.postBookmark(req, res);
    }

    static async deleteBookmark(req: Request, res: Response) {
        const bookmarkdomain = new BookmarkDomain();
        await bookmarkdomain.deleteBookmark(req, res);
    }
    static async userBookmark(req: Request, res: Response) {
        const bookmarkdomain = new BookmarkDomain();
        await bookmarkdomain.userBookmark(req, res);
    }
}


router.post('/post/:hotel_id', BookmarkController.postBookmark);
router.delete('/delete/:hotel_id', BookmarkController.deleteBookmark);
router.get('/user/wishlist', BookmarkController.userBookmark);
export { router };