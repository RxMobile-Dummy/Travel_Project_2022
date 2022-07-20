import mongoose from "mongoose";

const BookmarkSchema = new mongoose.Schema({
    _id: { type: Number, required: true, unique: true },
    hotel_id: { type: Number, required: true, ref: 'hotels' },
    user_id: {type: String, required: true, ref: 'users'}
});

const bookmarkmodel = mongoose.model('bookmarks', BookmarkSchema);
export { bookmarkmodel }