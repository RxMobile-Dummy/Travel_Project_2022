import 'dart:convert';

import '../../../hotel_detail/data/model/hotel_detail_model.dart';
/// hotel_id : 1
/// hotel_name : "Hotel Khyber Palace"
/// room_id : 102
/// room_type : "Semi-Deluxe"
/// room_size : "100 square feet"
/// bed_size : "Twin bed"
/// max_capacity : 2
/// price : 5500
/// features : ["Free internet","Coffee / Tea maker","Mini-Fridge","Smart TV with satellite","Individually air conditioning"]
/// description : "Semi-Deluxe rooms, are modern decorated, can accommodate up to 2 persons, totally soundproofed and equipped with high tech comforts such as high speed internet access, USB ports , smart TV, room cleaning touch system and private hydromassage bathtub"
/// images : [{"_id":6,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F1.jpg?alt=media&token=7ffb9c24-4acb-444e-ad28-12a40b619698","hotel_id":1,"room_id":102,"tour_id":null,"user_id":null},{"_id":7,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F10.jpg?alt=media&token=ef24362d-f35b-47cd-ba6d-ee0f8c86992b","hotel_id":1,"room_id":102,"tour_id":null,"user_id":null},{"_id":8,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F11.jpg?alt=media&token=32b7a860-63cd-42d6-9eef-d8ca1108cbee","hotel_id":1,"room_id":102,"tour_id":null,"user_id":null},{"_id":9,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F12.jpg?alt=media&token=738c4f05-66f4-40cf-9b54-0373b086410a","hotel_id":1,"room_id":102,"tour_id":null,"user_id":null},{"_id":10,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F13.jpg?alt=media&token=224f046d-4867-4cd9-a3ef-db632cadb993","hotel_id":1,"room_id":102,"tour_id":null,"user_id":null}]
RoomDetailModel roomDetailModelFromJson(String str) => RoomDetailModel.fromJson(json.decode(str));
String roomDetailModelToJson(RoomDetailModel data) => json.encode(data.toJson());
class RoomDetailModel {
  RoomDetailModel({
    this.hotelId,
    this.hotelName,
    this.roomId,
    this.roomType,
    this.roomSize,
    this.bedSize,
    this.maxCapacity,
    this.price,
    this.features,
    this.description,
    this.images,});

  RoomDetailModel.fromJson(dynamic json) {
    hotelId = json['hotel_id'];
    hotelName = json['hotel_name'];
    roomId = json['room_id'];
    roomType = json['room_type'];
    roomSize = json['room_size'];
    bedSize = json['bed_size'];
    maxCapacity = json['max_capacity'];
    price = json['price'];
    features = json['features'] != null ? json['features'].cast<String>() : [];
    description = json['description'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
  }
  int? hotelId;
  String? hotelName;
  int? roomId;
  String? roomType;
  String? roomSize;
  String? bedSize;
  int? maxCapacity;
  int? price;
  List<String>? features;
  String? description;
  List<Images>? images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hotel_id'] = hotelId;
    map['hotel_name'] = hotelName;
    map['room_id'] = roomId;
    map['room_type'] = roomType;
    map['room_size'] = roomSize;
    map['bed_size'] = bedSize;
    map['max_capacity'] = maxCapacity;
    map['price'] = price;
    map['features'] = features;
    map['description'] = description;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : 6
/// image_url : "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F1.jpg?alt=media&token=7ffb9c24-4acb-444e-ad28-12a40b619698"
/// hotel_id : 1
/// room_id : 102
/// tour_id : null
/// user_id : null
// Images imagesFromJson(String str) => Images.fromJson(json.decode(str));
// String imagesToJson(Images data) => json.encode(data.toJson());
// class Images {
//   Images({
//     this.id,
//     this.imageUrl,
//     this.hotelId,
//     this.roomId,
//     this.tourId,
//     this.userId,});
//
//   Images.fromJson(dynamic json) {
//     id = json['_id'];
//     imageUrl = json['image_url'];
//     hotelId = json['hotel_id'];
//     roomId = json['room_id'];
//     tourId = json['tour_id'];
//     userId = json['user_id'];
//   }
//   int? id;
//   String? imageUrl;
//   int? hotelId;
//   int? roomId;
//   dynamic tourId;
//   dynamic userId;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['_id'] = id;
//     map['image_url'] = imageUrl;
//     map['hotel_id'] = hotelId;
//     map['room_id'] = roomId;
//     map['tour_id'] = tourId;
//     map['user_id'] = userId;
//     return map;
//   }
//
// }