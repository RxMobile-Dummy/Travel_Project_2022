import mongoose from "mongoose";

const UserSchema = new mongoose.Schema({

    _id: { type: String, required: true, unique: true },
    user_name: { type: String, required: true, minlength: 1, maxlength: 30 },
    user_email: { type: String, required: true, unique: true },
    user_phone_number: { type: String, minlength: 10, maxlength: 14 },
    user_image: { type: String },
    user_type : {type: String}

});

const Usermodel = mongoose.model('users', UserSchema)
export { Usermodel };

