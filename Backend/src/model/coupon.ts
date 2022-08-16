import mongoose from "mongoose";

const CouponSchema = new mongoose.Schema({
    _id: {type: Number,required: true ,unique:true},
    code : {type: String,required : true,unique:true},
    description : {type : Number,required : true},
    couponImgUrl:{type:String,required:true},
    discount : {type : Number,required : true},
    minValue: {type:Number},
    maxOrderValue:{type:Number},
    noOfUser:{type:Number},
    eligibleFor:{type:String,enum : ['NEW','EXISTING','ALL'],default: 'ALL'},
    startDate: {type:Date,required : true},
    endDate: {type:Date,required : true},

});

const couponmodel = mongoose.model('coupon',CouponSchema);
export {couponmodel}