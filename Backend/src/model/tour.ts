import mongoose from "mongoose";

//tour schema

const TourSchema = new mongoose.Schema({
    _id: {type: Number,required: true ,unique:true},
    tour_name : {type: String,required : true},
    rating : {type: Number,required : true},
    price : {type: Number,required : true}
})
const tourmodel = mongoose.model('tours',TourSchema)

// export tour model 
export {tourmodel};