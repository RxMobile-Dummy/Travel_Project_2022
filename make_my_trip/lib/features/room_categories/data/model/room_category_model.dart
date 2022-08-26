import 'dart:convert';

import 'package:make_my_trip/features/home_page/data/models/imageModel.dart';

RoomCategoryModel roomCategoryModelFromJson(String str) =>
    RoomCategoryModel.fromJson(json.decode(str));

class RoomCategoryModel {
  RoomCategoryModel({
    this.hotelId,
    this.hotelName,
    this.hotelMattressPrize,
    this.deluxeRoomId,
    this.deluxe,
    this.semideluxeRoomId,
    this.semideluxe,
    this.superdeluxeRoomId,
    this.supedeluxe,
  });

  RoomCategoryModel.fromJson(Map<String, dynamic> json) {
    hotelId = json['hotel_id'];
    hotelName = json['hotel_name'];
    hotelMattressPrize = json['hotelMattressPrize'];
    deluxeRoomId = json['deluxe_room_id'].toList();
    deluxe = Deluxe.fromJson(json['deluxe']);
    semideluxeRoomId = json['semideluxe_room_id'].toList();
    semideluxe = Deluxe.fromJson(json['semideluxe']);
    superdeluxeRoomId = json['superdeluxe_room_id'].toList();
    supedeluxe = Deluxe.fromJson(json['supedeluxe']);
  }
  String? hotelId;
  String? hotelName;
  int? hotelMattressPrize;
  List<dynamic>? deluxeRoomId;
  Deluxe? deluxe;
  List<dynamic>? semideluxeRoomId;
  Deluxe? semideluxe;
  List<dynamic>? superdeluxeRoomId;
  Deluxe? supedeluxe;
}

class Deluxe {
  Deluxe({
    this.roomId,
    this.roomType,
    this.roomSize,
    this.bedSize,
    this.maxCapacity,
    this.price,
    this.features,
    this.description,
    this.image,
  });

  Deluxe.fromJson(dynamic json) {
    roomId = json['room_id'];
    roomType = json['room_type'];
    roomSize = json['room_size'];
    bedSize = json['bed_size'];
    maxCapacity = json['max_capacity'];
    price = json['price'];
    features = json['features'] != null ? json['features'].cast<String>() : [];
    description = json['description'];
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(ImageModel.fromJson(v));
      });
    }
  }
  int? roomId;
  String? roomType;
  String? roomSize;
  String? bedSize;
  int? maxCapacity;
  int? price;
  List<String>? features;
  String? description;
  List<ImageModel>? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['room_id'] = roomId;
    map['room_type'] = roomType;
    map['room_size'] = roomSize;
    map['bed_size'] = bedSize;
    map['max_capacity'] = maxCapacity;
    map['price'] = price;
    map['features'] = features;
    map['description'] = description;
    if (image != null) {
      map['image'] = image?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
