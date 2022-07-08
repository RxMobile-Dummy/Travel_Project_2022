import mongoose from "mongoose";

const UserSchema = new mongoose.Schema({
    _id: {type: Number,required: true ,unique:true},
    user_name: {type : String},
    user_email :{type : String},
    user_phone_number : {type : String ,minlength : 10 , maxlength : 10},
   // user_image:
});

const usermodel = mongoose.model('users',UserSchema)
export {usermodel};

