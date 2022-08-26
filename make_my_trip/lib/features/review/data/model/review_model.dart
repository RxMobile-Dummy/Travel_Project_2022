import 'dart:convert';

/// hotel_id : 2
/// hotelRating : 2.5
/// avgCleanliness : 3.5
/// avgComfort : 3.5
/// avgLocation : 3.5
/// avgFacilities : 2.5
/// reviews : [{"_id":1,"user_id":{"user_name":"nd","user_image":"https://lh3.googleusercontent.com/a/AItbvmm7d_MlCoMQqiTsWLEYYDkM9jvuARcXFB4Wg1b8=s96-c"},"hotel_id":2,"date":"2022-08-09T04:26:20.561Z","comment":"hii","cleanliness":3.5,"comfort":3.5,"location":3.5,"facilities":2.5,"rating":3.125}]
ReviewModel reviewModelFromJson(String str) =>
    ReviewModel.fromJson(json.decode(str));
String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  ReviewModel({
    this.hotelId,
    this.hotelRating,
    this.avgCleanliness,
    this.avgComfort,
    this.avgLocation,
    this.avgFacilities,
    this.reviews,
  });
  ReviewModel.fromJson(dynamic json) {
    hotelId = json['hotel_id'];
    hotelRating = json['hotelRating'].toDouble();
    avgCleanliness = json['avgCleanliness'].toDouble();
    avgComfort = json['avgComfort'].toDouble();
    avgLocation = json['avgLocation'].toDouble();
    avgFacilities = json['avgFacilities'].toDouble();
    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews?.add(Reviews.fromJson(v));
      });
    }
  }
  int? hotelId;
  double? hotelRating;
  double? avgCleanliness;
  double? avgComfort;
  double? avgLocation;
  double? avgFacilities;
  List<Reviews>? reviews;
  ReviewModel copyWith({
    int? hotelId,
    double? hotelRating,
    double? avgCleanliness,
    double? avgComfort,
    double? avgLocation,
    double? avgFacilities,
    List<Reviews>? reviews,
  }) =>
      ReviewModel(
        hotelId: hotelId ?? this.hotelId,
        hotelRating: hotelRating ?? this.hotelRating,
        avgCleanliness: avgCleanliness ?? this.avgCleanliness,
        avgComfort: avgComfort ?? this.avgComfort,
        avgLocation: avgLocation ?? this.avgLocation,
        avgFacilities: avgFacilities ?? this.avgFacilities,
        reviews: reviews ?? this.reviews,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hotel_id'] = hotelId;
    map['hotelRating'] = hotelRating;
    map['avgCleanliness'] = avgCleanliness;
    map['avgComfort'] = avgComfort;
    map['avgLocation'] = avgLocation;
    map['avgFacilities'] = avgFacilities;
    if (reviews != null) {
      map['reviews'] = reviews?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : 1
/// user_id : {"user_name":"nd","user_image":"https://lh3.googleusercontent.com/a/AItbvmm7d_MlCoMQqiTsWLEYYDkM9jvuARcXFB4Wg1b8=s96-c"}
/// hotel_id : 2
/// date : "2022-08-09T04:26:20.561Z"
/// comment : "hii"
/// cleanliness : 3.5
/// comfort : 3.5
/// location : 3.5
/// facilities : 2.5
/// rating : 3.125
Reviews reviewsFromJson(String str) => Reviews.fromJson(json.decode(str));
String reviewsToJson(Reviews data) => json.encode(data.toJson());

class Reviews {
  Reviews({
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
    this.images,
  });
  Reviews.fromJson(dynamic json) {
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
    images = json['imageUrl'].toList();
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
  List<String>? images;
  Reviews copyWith(
          {int? id,
          UserId? userId,
          int? hotelId,
          String? date,
          String? comment,
          double? cleanliness,
          double? comfort,
          double? location,
          double? facilities,
          double? rating,
          List<String>? images}) =>
      Reviews(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        hotelId: hotelId ?? this.hotelId,
        date: date ?? this.date,
        comment: comment ?? this.comment,
        cleanliness: cleanliness ?? this.cleanliness,
        comfort: comfort ?? this.comfort,
        location: location ?? this.location,
        facilities: facilities ?? this.facilities,
        rating: rating ?? this.rating,
        images: images ?? this.images,
      );
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
    map['imageUrl'] = images;
    return map;
  }
}

/// user_name : "nd"
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
  UserId copyWith({
    String? userName,
    String? userImage,
  }) =>
      UserId(
        userName: userName ?? this.userName,
        userImage: userImage ?? this.userImage,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = userName;
    map['user_image'] = userImage;
    return map;
  }
}
