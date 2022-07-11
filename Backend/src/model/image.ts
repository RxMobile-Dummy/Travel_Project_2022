import mongoose from "mongoose";

const ImageSchema = new mongoose.Schema({
    _id: {type: Number,required: true ,unique:true},
    image_url : {type: String,required : true},
    hotel_id : {type : Number,
        ref: 'hotels'
    },
    room_id : {type : Number,

    },tour_id:{
        type : Number,
       
    },user_id:{
        type:Number,
        ref: 'users'
    }
});

const imagemodel = mongoose.model('images',ImageSchema);
export {imagemodel}