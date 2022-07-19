import 'dart:convert';

/// hotel_id : 5
/// hotel_name : "Lemon Tree Hotel, Ahmedabad"
/// room_data : [{"room_id":501,"room_type":"Deluxe","room_size":"150 square feet","bed_size":"Twin bed","max_capacity":2,"price":5000,"features":["Free internet","Coffee / Tea maker","Soundproof walls","Smart TV with satellite","Individually air conditioning"],"description":"Deluxe rooms, are modern decorated, can accommodate up to 2 persons, totally soundproofed and equipped with high tech comforts such as high speed internet access, USB ports , smart TV, room cleaning touch system and private hydromassage bathtub","images":[{"_id":91,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":501,"tour_id":null,"user_id":null},{"_id":92,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":501,"tour_id":null,"user_id":null},{"_id":93,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":501,"tour_id":null,"user_id":null},{"_id":94,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":501,"tour_id":null,"user_id":null},{"_id":95,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":501,"tour_id":null,"user_id":null}]},{"room_id":502,"room_type":"Semi-Deluxe","room_size":"100 square feet","bed_size":"Twin bed","max_capacity":2,"price":5500,"features":["Free internet","Coffee / Tea maker","Mini-Fridge","Smart TV with satellite","Individually air conditioning"],"description":"Semi-Deluxe rooms, are modern decorated, can accommodate up to 2 persons, totally soundproofed and equipped with high tech comforts such as high speed internet access, USB ports , smart TV, room cleaning touch system and private hydromassage bathtub","images":[{"_id":96,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":502,"tour_id":null,"user_id":null},{"_id":97,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":502,"tour_id":null,"user_id":null},{"_id":98,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":502,"tour_id":null,"user_id":null},{"_id":99,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":502,"tour_id":null,"user_id":null},{"_id":100,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":502,"tour_id":null,"user_id":null},{"_id":101,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":502,"tour_id":null,"user_id":null},{"_id":102,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":502,"tour_id":null,"user_id":null},{"_id":103,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":502,"tour_id":null,"user_id":null},{"_id":104,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":502,"tour_id":null,"user_id":null},{"_id":105,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":502,"tour_id":null,"user_id":null}]},{"room_id":503,"room_type":"Super-Deluxe","room_size":"200 square feet","bed_size":"Twin bed","max_capacity":2,"price":8000,"features":["Free internet","Pet-Friendly Rooms","Coffee / Tea maker","Mini-Fridge","Smart TV with satellite","Individually air conditioning"],"description":"Super-Deluxe rooms, are modern decorated, can accommodate up to 2 persons, totally soundproofed and equipped with high tech comforts such as high speed internet access, USB ports , smart TV, room cleaning touch system and private hydromassage bathtub","images":[{"_id":106,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":503,"tour_id":null,"user_id":null},{"_id":107,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":503,"tour_id":null,"user_id":null},{"_id":108,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":503,"tour_id":null,"user_id":null},{"_id":109,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":503,"tour_id":null,"user_id":null},{"_id":110,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":503,"tour_id":null,"user_id":null}]}]

RoomCategoryModel roomCategoryModelFromJson(String str) =>
    RoomCategoryModel.fromJson(json.decode(str));
String roomCategoryModelToJson(RoomCategoryModel data) =>
    json.encode(data.toJson());

class RoomCategoryModel {
  RoomCategoryModel({
    this.hotelId,
    this.hotelName,
    this.roomData,
  });

  RoomCategoryModel.fromJson(dynamic json) {
    hotelId = json['hotel_id'];
    hotelName = json['hotel_name'];
    if (json['room_data'] != null) {
      roomData = [];
      json['room_data'].forEach((v) {
        roomData?.add(RoomData.fromJson(v));
      });
    }
  }
  int? hotelId;
  String? hotelName;
  List<RoomData>? roomData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hotel_id'] = hotelId;
    map['hotel_name'] = hotelName;
    if (roomData != null) {
      map['room_data'] = roomData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// room_id : 501
/// room_type : "Deluxe"
/// room_size : "150 square feet"
/// bed_size : "Twin bed"
/// max_capacity : 2
/// price : 5000
/// features : ["Free internet","Coffee / Tea maker","Soundproof walls","Smart TV with satellite","Individually air conditioning"]
/// description : "Deluxe rooms, are modern decorated, can accommodate up to 2 persons, totally soundproofed and equipped with high tech comforts such as high speed internet access, USB ports , smart TV, room cleaning touch system and private hydromassage bathtub"
/// images : [{"_id":91,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":501,"tour_id":null,"user_id":null},{"_id":92,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":501,"tour_id":null,"user_id":null},{"_id":93,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":501,"tour_id":null,"user_id":null},{"_id":94,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":501,"tour_id":null,"user_id":null},{"_id":95,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":5,"room_id":501,"tour_id":null,"user_id":null}]

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
    this.description,
    this.images,
  });

  RoomData.fromJson(dynamic json) {
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

/// _id : 91
/// image_url : "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6"
/// hotel_id : 5
/// room_id : 501
/// tour_id : null
/// user_id : null

Images imagesFromJson(String str) => Images.fromJson(json.decode(str));
String imagesToJson(Images data) => json.encode(data.toJson());

class Images {
  Images({
    this.id,
    this.imageUrl,
    this.hotelId,
    this.roomId,
    this.tourId,
    this.userId,
  });

  Images.fromJson(dynamic json) {
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
