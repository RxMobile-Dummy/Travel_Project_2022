import mongoose from "mongoose";

const ReviewSchema = new mongoose.Schema({
    _id: { type: Number, required: true, unique: true },
    user_id: { type: String, required: true, ref: 'users' },
    hotel_id: { type: Number, required: true, ref: 'hotels' },
    date: { type: Date },
    comment: { type: String, maxlength: 200 },
    cleanliness: { type: Number, min: 0, max: 5 },
    comfort: { type: Number, min: 0, max: 5 },
    location: { type: Number, min: 0, max: 5 },
    facilities: { type: Number, min: 0, max: 5 },
    rating: { type: Number, min: 0, max: 5 },
    status:{type:String},
    image:[{
        image_id:{type:Number},
        image_url:{type:String}
    }]
})

const reviewmodel = mongoose.model('reviews', ReviewSchema);
export { reviewmodel }