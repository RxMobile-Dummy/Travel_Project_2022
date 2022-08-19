import mongoose from "mongoose";

const deviceSchema = new mongoose.Schema({

    _id: {type: Number,required: true ,unique:true},

    device_id: { type: String, required: true, unique: true },

    useruid: { type: String, required: true },

    fcmtoken: { type: String, required: true },

    devicetype: { type: String, required: true }

});



const devicemodel = mongoose.model('devices', deviceSchema);



export { devicemodel }