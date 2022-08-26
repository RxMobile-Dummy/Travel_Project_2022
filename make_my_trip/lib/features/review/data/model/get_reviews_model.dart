import 'dart:convert';

/// hotel_id : 1
/// hotelRating : 3.9
/// avgCleanliness : 3.75
/// avgComfort : 3.75
/// avgLocation : 4
/// avgFacilities : 4.25
/// review : [{"_id":19,"user_id":{"user_name":"gokani gokani","user_image":"https://lh3.googleusercontent.com/a/AItbvmm7d_MlCoMQqiTsWLEYYDkM9jvuARcXFB4Wg1b8=s96-c"},"hotel_id":1,"date":"2022-08-09T08:10:19.610Z","comment":" wu5e6idoudkuduldiodhkdljxuldoydykdukdulduoduoduodyoduodulfoucifjlcjlfupfipfipfuodilripririruoeuoeuoeuoeo7eukduoduoeo6eyosiysyisyixyozyiztiyidy8dud9ud","cleanliness":4.5,"comfort":3.5,"location":4,"facilities":4.5,"rating":4.125,"status":"approve","image":[{"image_id":1,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/coupon_image%2F1.jpeg?alt=media&token=ac90b225-2ef1-4e5f-a2b5-1059a860249d"},{"image_id":2,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/coupon_image%2F1.jpeg?alt=media&token=ac90b225-2ef1-4e5f-a2b5-1059a860249d"},{"image_id":3,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/coupon_image%2F1.jpeg?alt=media&token=ac90b225-2ef1-4e5f-a2b5-1059a860249d"},{"image_id":4,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/coupon_image%2F1.jpeg?alt=media&token=ac90b225-2ef1-4e5f-a2b5-1059a860249d"}]},{"_id":30,"user_id":{"user_name":"Padmanava Karmakar","user_image":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/userImage%2Fscaled_image_picker526315976122597934.jpg?alt=media&token=377ca763-1672-4a99-9b2e-e62e70ba7432"},"hotel_id":1,"date":"2022-08-25T09:08:32.911Z","comment":"ek of","cleanliness":3,"comfort":4,"location":4,"facilities":4,"rating":3.75,"status":"approve","image":[{"image_id":1,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/review_images%2Fimageimage_picker558584863560782870.jpg?alt=media&token=7145c8fa-40c9-4245-8a86-1f209c130cab","_id":"63073c10b280faf6f8e51c0f"}]}]

GetReviewModel getReviewModelFromJson(String str) =>
    GetReviewModel.fromJson(json.decode(str));
String getReviewModelToJson(GetReviewModel data) => json.encode(data.toJson());

class GetReviewModel {
  GetReviewModel({
    this.hotelId,
    this.hotelRating,
    this.avgCleanliness,
    this.avgComfort,
    this.avgLocation,
    this.avgFacilities,
    this.review,
  });

  GetReviewModel.fromJson(dynamic json) {
    hotelId = json['hotel_id'];
    hotelRating = json['hotelRating'].toDouble();
    avgCleanliness = json['avgCleanliness'].toDouble();
    avgComfort = json['avgComfort'].toDouble();
    avgLocation = json['avgLocation'].toDouble();
    avgFacilities = json['avgFacilities'].toDouble();
    if (json['reviews'] != null) {
      review = [];
      json['reviews'].forEach((v) {
        review?.add(Review.fromJson(v));
      });
    }
  }
  int? hotelId;
  double? hotelRating;
  double? avgCleanliness;
  double? avgComfort;
  double? avgLocation;
  double? avgFacilities;
  List<Review>? review;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hotel_id'] = hotelId;
    map['hotelRating'] = hotelRating;
    map['avgCleanliness'] = avgCleanliness;
    map['avgComfort'] = avgComfort;
    map['avgLocation'] = avgLocation;
    map['avgFacilities'] = avgFacilities;
    if (review != null) {
      map['reviews'] = review?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : 19
/// user_id : {"user_name":"gokani gokani","user_image":"https://lh3.googleusercontent.com/a/AItbvmm7d_MlCoMQqiTsWLEYYDkM9jvuARcXFB4Wg1b8=s96-c"}
/// hotel_id : 1
/// date : "2022-08-09T08:10:19.610Z"
/// comment : " wu5e6idoudkuduldiodhkdljxuldoydykdukdulduoduoduodyoduodulfoucifjlcjlfupfipfipfuodilripririruoeuoeuoeuoeo7eukduoduoeo6eyosiysyisyixyozyiztiyidy8dud9ud"
/// cleanliness : 4.5
/// comfort : 3.5
/// location : 4
/// facilities : 4.5
/// rating : 4.125
/// status : "approve"
/// image : [{"image_id":1,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/coupon_image%2F1.jpeg?alt=media&token=ac90b225-2ef1-4e5f-a2b5-1059a860249d"},{"image_id":2,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/coupon_image%2F1.jpeg?alt=media&token=ac90b225-2ef1-4e5f-a2b5-1059a860249d"},{"image_id":3,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/coupon_image%2F1.jpeg?alt=media&token=ac90b225-2ef1-4e5f-a2b5-1059a860249d"},{"image_id":4,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/coupon_image%2F1.jpeg?alt=media&token=ac90b225-2ef1-4e5f-a2b5-1059a860249d"}]

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));
String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
  Review({
    this.id,
    this.userId,
    this.hotelId,
    this.date,
    this.comment,
    this.cleanliness,
    this.comfort,
    this.location,
    this.facilities,
    this.rating,
    this.status,
    this.image,
  });

  Review.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['user_id'] != null ? UserId.fromJson(json['user_id']) : null;
    hotelId = json['hotel_id'];
    date = json['date'];
    comment = json['comment'];
    cleanliness = json['cleanliness'].toDouble();
    comfort = json['comfort'].toDouble();
    location = json['location'].toDouble();
    facilities = json['facilities'].toDouble();
    rating = json['rating'].toDouble();
    status = json['status'];
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(Images.fromJson(v));
      });
    }
  }
  int? id;
  UserId? userId;
  int? hotelId;
  String? date;
  String? comment;
  double? cleanliness;
  double? comfort;
  double? location;
  double? facilities;
  double? rating;
  String? status;
  List<Images>? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (userId != null) {
      map['user_id'] = userId?.toJson();
    }
    map['hotel_id'] = hotelId;
    map['date'] = date;
    map['comment'] = comment;
    map['cleanliness'] = cleanliness;
    map['comfort'] = comfort;
    map['location'] = location;
    map['facilities'] = facilities;
    map['rating'] = rating;
    map['status'] = status;
    if (image != null) {
      map['image'] = image?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// image_id : 1
/// image_url : "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/coupon_image%2F1.jpeg?alt=media&token=ac90b225-2ef1-4e5f-a2b5-1059a860249d"

Images imageFromJson(String str) => Images.fromJson(json.decode(str));
String imageToJson(Images data) => json.encode(data.toJson());

class Images {
  Images({
    this.imageId,
    this.imageUrl,
  });

  Images.fromJson(dynamic json) {
    imageId = json['image_id'];
    imageUrl = json['image_url'];
  }
  int? imageId;
  String? imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image_id'] = imageId;
    map['image_url'] = imageUrl;
    return map;
  }
}

/// user_name : "gokani gokani"
/// user_image : "https://lh3.googleusercontent.com/a/AItbvmm7d_MlCoMQqiTsWLEYYDkM9jvuARcXFB4Wg1b8=s96-c"

UserId userIdFromJson(String str) => UserId.fromJson(json.decode(str));
String userIdToJson(UserId data) => json.encode(data.toJson());

class UserId {
  UserId({
    this.userName,
    this.userImage,
  });

  UserId.fromJson(dynamic json) {
    userName = json['user_name'];
    userImage = json['user_image'];
  }
  String? userName;
  String? userImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = userName;
    map['user_image'] = userImage;
    return map;
  }
}
