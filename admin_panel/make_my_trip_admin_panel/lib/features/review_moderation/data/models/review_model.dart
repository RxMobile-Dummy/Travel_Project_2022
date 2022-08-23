import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {

  int? id;
  UserId? userId;
  HotelId? hotelId;
  String? date;
  String? comment;
  double? cleanliness;
  double? comfort;
  double? location;
  double? facilities;
  double? rating;
  List<ReviewImage>? image;

  ReviewModel({this.id,
    this.userId,
    this.hotelId,
    this.date,
    this.comment,
    this.cleanliness,
    this.comfort,
    this.location,
    this.facilities,
    this.rating,
    this.image});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId =
    json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    hotelId = json['hotel_id'] != null
        ? new HotelId.fromJson(json['hotel_id'])
        : null;
    date = json['date'];
    comment = json['comment'];
    cleanliness = json['cleanliness'].toDouble();
    comfort = json['comfort'].toDouble();
    location = json['location'].toDouble();
    facilities = json['facilities'].toDouble();
    rating = json['rating'].toDouble();
    if (json['image'] != null) {
      image = <ReviewImage>[];
      json['image'].forEach((v) {
        image!.add(new ReviewImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
    if (this.hotelId != null) {
      data['hotel_id'] = this.hotelId!.toJson();
    }
    data['date'] = this.date;
    data['comment'] = this.comment;
    data['cleanliness'] = this.cleanliness;
    data['comfort'] = this.comfort;
    data['location'] = this.location;
    data['facilities'] = this.facilities;
    data['rating'] = this.rating;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [id,userId,hotelId,date,comment,cleanliness,comfort,location,facilities,rating,image];
}

class UserId {
  String? userName;
  String? userImage;

  UserId({this.userName, this.userImage});

  UserId.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_image'] = this.userImage;
    return data;
  }
}

class HotelId {
  int? iId;
  String? hotelName;

  HotelId({this.iId, this.hotelName});

  HotelId.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    hotelName = json['hotel_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['hotel_name'] = this.hotelName;
    return data;
  }
}

class ReviewImage {
  int? imageId;
  String? imageUrl;

  ReviewImage({this.imageId, this.imageUrl});

  ReviewImage.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_id'] = this.imageId;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
