import 'dart:convert';

/// _id : 1
/// user_id : {"user_name":"Rushi Gandhi hhh","user_image":"https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_960_720.png"}
/// hotel_id : 1
/// date : "2022-07-15T07:23:13.459Z"
/// rating : 2.125
/// comment : "hyy"
/// cleanliness : 2.5
/// comfort : 3
/// location : 2
/// facilities : 1

ReviewModel reviewModelFromJson(String str) =>
    ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  ReviewModel({
    int? id,
    UserId? userId,
    int? hotelId,
    String? date,
    double? rating,
    String? comment,
    double? cleanliness,
    double? comfort,
    double? location,
    double? facilities,
  }) {
    _id = id;
    _userId = userId;
    _hotelId = hotelId;
    _date = date;
    _rating = rating;
    _comment = comment;
    _cleanliness = cleanliness;
    _comfort = comfort;
    _location = location;
    _facilities = facilities;
  }

  ReviewModel.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['user_id'] != null ? UserId.fromJson(json['user_id']) : null;
    _hotelId = json['hotel_id'];
    _date = json['date'];
    _rating = json['rating'].toDouble();
    _comment = json['comment'];
    _cleanliness = json['cleanliness'].toDouble();
    _comfort = json['comfort'].toDouble();
    _location = json['location'].toDouble();
    _facilities = json['facilities'].toDouble();
  }

  int? _id;
  UserId? _userId;
  int? _hotelId;
  String? _date;
  double? _rating;
  String? _comment;
  double? _cleanliness;
  double? _comfort;
  double? _location;
  double? _facilities;

  ReviewModel copyWith({
    int? id,
    UserId? userId,
    int? hotelId,
    String? date,
    double? rating,
    String? comment,
    double? cleanliness,
    double? comfort,
    double? location,
    double? facilities,
  }) =>
      ReviewModel(
        id: id ?? _id,
        userId: userId ?? _userId,
        hotelId: hotelId ?? _hotelId,
        date: date ?? _date,
        rating: rating ?? _rating,
        comment: comment ?? _comment,
        cleanliness: cleanliness ?? _cleanliness,
        comfort: comfort ?? _comfort,
        location: location ?? _location,
        facilities: facilities ?? _facilities,
      );

  int? get id => _id;

  UserId? get userId => _userId;

  int? get hotelId => _hotelId;

  String? get date => _date;

  double? get rating => _rating;

  String? get comment => _comment;

  double? get cleanliness => _cleanliness;

  double? get comfort => _comfort;

  double? get location => _location;

  double? get facilities => _facilities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_userId != null) {
      map['user_id'] = _userId?.toJson();
    }
    map['hotel_id'] = _hotelId;
    map['date'] = _date;
    map['rating'] = _rating;
    map['comment'] = _comment;
    map['cleanliness'] = _cleanliness;
    map['comfort'] = _comfort;
    map['location'] = _location;
    map['facilities'] = _facilities;
    return map;
  }
}

/// user_name : "Rushi Gandhi hhh"
/// user_image : "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_960_720.png"

UserId userIdFromJson(String str) => UserId.fromJson(json.decode(str));

String userIdToJson(UserId data) => json.encode(data.toJson());

class UserId {
  UserId({
    String? userName,
    String? userImage,
  }) {
    _userName = userName;
    _userImage = userImage;
  }

  UserId.fromJson(dynamic json) {
    _userName = json['user_name'];
    _userImage = json['user_image'];
  }

  String? _userName;
  String? _userImage;

  UserId copyWith({
    String? userName,
    String? userImage,
  }) =>
      UserId(
        userName: userName ?? _userName,
        userImage: userImage ?? _userImage,
      );

  String? get userName => _userName;

  String? get userImage => _userImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = _userName;
    map['user_image'] = _userImage;
    return map;
  }
}
