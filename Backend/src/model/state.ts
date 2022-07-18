import mongoose from "mongoose";

const StateSchema = new mongoose.Schema({
    _id: {type: Number,required: true ,unique:true},
    state_name : {type: String,required : true}
});

const statemodel = mongoose.model('states',StateSchema)
export {statemodel};