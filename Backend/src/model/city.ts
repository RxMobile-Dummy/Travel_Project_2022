import mongoose from "mongoose";

const CitySchema = new mongoose.Schema({
    _id: {type: Number,required: true ,unique:true},
    city_name : {type: String,required : true},
    state_id : {type : Number,
        ref: 'states'
    }
});

const citymodel = mongoose.model('cities',CitySchema);
export {citymodel}