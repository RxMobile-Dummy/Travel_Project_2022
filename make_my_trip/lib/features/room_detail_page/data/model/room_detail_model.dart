import 'dart:convert';
/// hotel_id : 1
/// hotel_name : "Hotel Khyber Palace"
/// room_data : {"room_id":103,"room_type":"Super-Deluxe","room_size":"200 square feet","bed_size":"Twin bed","max_capacity":2,"price":8000,"features":["Free internet","Pet-Friendly Rooms","Coffee / Tea maker","Mini-Fridge","Smart TV with satellite","Individually air conditioning"],"description":"Super-Deluxe rooms, are modern decorated, can accommodate up to 2 persons, totally soundproofed and equipped with high tech comforts such as high speed internet access, USB ports , smart TV, room cleaning touch system and private hydromassage bathtub"}
/// room_image : [{"_id":11,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F3.jpg?alt=media&token=a7f27b46-211f-46fc-a689-af797ad3bcc4","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null},{"_id":12,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F2.jpg?alt=media&token=db35f435-2bb1-46f5-8e13-2686086e92b8","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null},{"_id":13,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F15.jpg?alt=media&token=5713f4fc-8559-4fde-82c4-10d34b5b07d6","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null},{"_id":14,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F14.jpg?alt=media&token=4fe38e88-a697-41f7-8e02-d884dec066e9","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null},{"_id":15,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F14.jpg?alt=media&token=4fe38e88-a697-41f7-8e02-d884dec066e9","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null}]

RoomDetailsModel roomDetailsModelFromJson(String str) => RoomDetailsModel.fromJson(json.decode(str));
String roomDetailsModelToJson(RoomDetailsModel data) => json.encode(data.toJson());
class RoomDetailsModel {
  RoomDetailsModel({
    this.hotelId,
    this.hotelName,
    this.roomData,
    this.roomImage,});

  RoomDetailsModel.fromJson(dynamic json) {
    hotelId = json['hotel_id'];
    hotelName = json['hotel_name'];
    roomData = json['room_data'] != null ? RoomData.fromJson(json['room_data']) : null;
    if (json['room_image'] != null) {
      roomImage = [];
      json['room_image'].forEach((v) {
        roomImage?.add(RoomImage.fromJson(v));
      });
    }
  }
  int? hotelId;
  String? hotelName;
  RoomData? roomData;
  List<RoomImage>? roomImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hotel_id'] = hotelId;
    map['hotel_name'] = hotelName;
    if (roomData != null) {
      map['room_data'] = roomData?.toJson();
    }
    if (roomImage != null) {
      map['room_image'] = roomImage?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : 11
/// image_url : "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F3.jpg?alt=media&token=a7f27b46-211f-46fc-a689-af797ad3bcc4"
/// hotel_id : 1
/// room_id : 103
/// tour_id : null
/// user_id : null

RoomImage roomImageFromJson(String str) => RoomImage.fromJson(json.decode(str));
String roomImageToJson(RoomImage data) => json.encode(data.toJson());
class RoomImage {
  RoomImage({
    this.id,
    this.imageUrl,
    this.hotelId,
    this.roomId,
    this.tourId,
    this.userId,});

  RoomImage.fromJson(dynamic json) {
    id = json['_id'];
    imageUrl = json['image_url'];
    hotelId = json['hotel_id'];
    roomId = json['room_id'];
    tourId = json['tour_id'];
    userId = json['user_id'];
  }
  int? id;
  String? imageUrl;
  int? hotelId;
  int? roomId;
  dynamic tourId;
  dynamic userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['image_url'] = imageUrl;
    map['hotel_id'] = hotelId;
    map['room_id'] = roomId;
    map['tour_id'] = tourId;
    map['user_id'] = userId;
    return map;
  }

}

/// room_id : 103
/// room_type : "Super-Deluxe"
/// room_size : "200 square feet"
/// bed_size : "Twin bed"
/// max_capacity : 2
/// price : 8000
/// features : ["Free internet","Pet-Friendly Rooms","Coffee / Tea maker","Mini-Fridge","Smart TV with satellite","Individually air conditioning"]
/// description : "Super-Deluxe rooms, are modern decorated, can accommodate up to 2 persons, totally soundproofed and equipped with high tech comforts such as high speed internet access, USB ports , smart TV, room cleaning touch system and private hydromassage bathtub"

RoomData roomDataFromJson(String str) => RoomData.fromJson(json.decode(str));
String roomDataToJson(RoomData data) => json.encode(data.toJson());
class RoomData {
  RoomData({
    this.roomId,
    this.roomType,
    this.roomSize,
    this.bedSize,
    this.maxCapacity,
    this.price,
    this.features,
    this.description,});

  RoomData.fromJson(dynamic json) {
    roomId = json['room_id'];
    roomType = json['room_type'];
    roomSize = json['room_size'];
    bedSize = json['bed_size'];
    maxCapacity = json['max_capacity'];
    price = json['price'];
    features = json['features'] != null ? json['features'].cast<String>() : [];
    description = json['description'];
  }
  int? roomId;
  String? roomType;
  String? roomSize;
  String? bedSize;
  int? maxCapacity;
  int? price;
  List<String>? features;
  String? description;

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
    return map;
  }

}