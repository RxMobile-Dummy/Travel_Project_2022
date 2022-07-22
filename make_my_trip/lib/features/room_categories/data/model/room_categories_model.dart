 import 'dart:convert';
//
// /// hotel_id : 1
// /// hotel_name : "Hotel Khyber Palace"
// /// deluxe : [{"room_id":101,"room_type":"Deluxe","room_size":"150 square feet","bed_size":"Twin bed","max_capacity":2,"price":5000,"features":["Free internet","Coffee / Tea maker","Soundproof walls","Smart TV with satellite","Individually air conditioning"],"description":"Deluxe rooms, are modern decorated, can accommodate up to 2 persons, totally soundproofed and equipped with high tech comforts such as high speed internet access, USB ports , smart TV, room cleaning touch system and private hydromassage bathtub","image":[{"_id":1,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fdelux%20room%2F13.jpg?alt=media&token=a573ef73-8a3c-4981-80ee-7ab11cdfce27","hotel_id":1,"room_id":101,"tour_id":null,"user_id":null},{"_id":2,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fdelux%20room%2F12'.jpg?alt=media&token=db5dacf0-d7fa-4b09-b7c4-59767c407b2a","hotel_id":1,"room_id":101,"tour_id":null,"user_id":null},{"_id":3,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fdelux%20room%2F11.jpg?alt=media&token=c3c0dea1-f47e-458e-b111-4a6091662cec","hotel_id":1,"room_id":101,"tour_id":null,"user_id":null},{"_id":4,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fdelux%20room%2F10.jpg?alt=media&token=210136e9-a6af-436e-b566-9e16027aa78d","hotel_id":1,"room_id":101,"tour_id":null,"user_id":null},{"_id":5,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fdelux%20room%2F1.jpg?alt=media&token=4f92b982-3097-4cf9-9418-2f0be7583a0e","hotel_id":1,"room_id":101,"tour_id":null,"user_id":null}]}]
// /// semi-deluxe : [{"room_id":103,"room_type":"Super-Deluxe","room_size":"200 square feet","bed_size":"Twin bed","max_capacity":2,"price":8000,"features":["Free internet","Pet-Friendly Rooms","Coffee / Tea maker","Mini-Fridge","Smart TV with satellite","Individually air conditioning"],"description":"Super-Deluxe rooms, are modern decorated, can accommodate up to 2 persons, totally soundproofed and equipped with high tech comforts such as high speed internet access, USB ports , smart TV, room cleaning touch system and private hydromassage bathtub","image":[{"_id":11,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F3.jpg?alt=media&token=a7f27b46-211f-46fc-a689-af797ad3bcc4","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null},{"_id":12,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F2.jpg?alt=media&token=db35f435-2bb1-46f5-8e13-2686086e92b8","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null},{"_id":13,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F15.jpg?alt=media&token=5713f4fc-8559-4fde-82c4-10d34b5b07d6","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null},{"_id":14,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F14.jpg?alt=media&token=4fe38e88-a697-41f7-8e02-d884dec066e9","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null},{"_id":15,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F14.jpg?alt=media&token=4fe38e88-a697-41f7-8e02-d884dec066e9","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null}]}]
// /// super-deluxe : [{"room_id":103,"room_type":"Super-Deluxe","room_size":"200 square feet","bed_size":"Twin bed","max_capacity":2,"price":8000,"features":["Free internet","Pet-Friendly Rooms","Coffee / Tea maker","Mini-Fridge","Smart TV with satellite","Individually air conditioning"],"description":"Super-Deluxe rooms, are modern decorated, can accommodate up to 2 persons, totally soundproofed and equipped with high tech comforts such as high speed internet access, USB ports , smart TV, room cleaning touch system and private hydromassage bathtub","image":[{"_id":11,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F3.jpg?alt=media&token=a7f27b46-211f-46fc-a689-af797ad3bcc4","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null},{"_id":12,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F2.jpg?alt=media&token=db35f435-2bb1-46f5-8e13-2686086e92b8","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null},{"_id":13,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F15.jpg?alt=media&token=5713f4fc-8559-4fde-82c4-10d34b5b07d6","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null},{"_id":14,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F14.jpg?alt=media&token=4fe38e88-a697-41f7-8e02-d884dec066e9","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null},{"_id":15,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F14.jpg?alt=media&token=4fe38e88-a697-41f7-8e02-d884dec066e9","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null}]}]
//
// RoomCategoryModel modelFromJson(String str) =>
//     RoomCategoryModel.fromJson(json.decode(str));
//
// String modelToJson(RoomCategoryModel data) => json.encode(data.toJson());
//
// class RoomCategoryModel {
//   RoomCategoryModel({
//     int? hotelId,
//     String? hotelName,
//     List<RoomType>? deluxe,
//     List<RoomType>? semideluxe,
//     List<RoomType>? superdeluxe,
//   }) {
//     _hotelId = hotelId;
//     _hotelName = hotelName;
//     _deluxe = deluxe;
//     _semideluxe = semideluxe;
//     _superdeluxe = superdeluxe;
//   }
//
//   RoomCategoryModel.fromJson(dynamic json) {
//     _hotelId = json['hotel_id'];
//     _hotelName = json['hotel_name'];
//     if (json['deluxe'] != null) {
//       _deluxe = [];
//       json['deluxe'].forEach((v) {
//         _deluxe?.add(RoomType.fromJson(v));
//       });
//     }
//     if (json['semi-deluxe'] != null) {
//       _semideluxe = [];
//       json['semi-deluxe'].forEach((v) {
//         _semideluxe?.add(RoomType.fromJson(v));
//       });
//     }
//     if (json['super-deluxe'] != null) {
//       _superdeluxe = [];
//       json['super-deluxe'].forEach((v) {
//         _superdeluxe?.add(RoomType.fromJson(v));
//       });
//     }
//   }
//
//   int? _hotelId;
//   String? _hotelName;
//   List<RoomType>? _deluxe;
//   List<RoomType>? _semideluxe;
//   List<RoomType>? _superdeluxe;
//
//   int? get hotelId => _hotelId;
//
//   String? get hotelName => _hotelName;
//
//   List<RoomType>? get deluxe => _deluxe;
//
//   List<RoomType>? get semideluxe => _semideluxe;
//
//   List<RoomType>? get superdeluxe => _superdeluxe;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['hotel_id'] = _hotelId;
//     map['hotel_name'] = _hotelName;
//     if (_deluxe != null) {
//       map['deluxe'] = _deluxe?.map((v) => v.toJson()).toList();
//     }
//     if (_semideluxe != null) {
//       map['semi-deluxe'] = _semideluxe?.map((v) => v.toJson()).toList();
//     }
//     if (_superdeluxe != null) {
//       map['super-deluxe'] = _superdeluxe?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }
//
// /// room_id : 103
// /// room_type : "Super-Deluxe"
// /// room_size : "200 square feet"
// /// bed_size : "Twin bed"
// /// max_capacity : 2
// /// price : 8000
// /// features : ["Free internet","Pet-Friendly Rooms","Coffee / Tea maker","Mini-Fridge","Smart TV with satellite","Individually air conditioning"]
// /// description : "Super-Deluxe rooms, are modern decorated, can accommodate up to 2 persons, totally soundproofed and equipped with high tech comforts such as high speed internet access, USB ports , smart TV, room cleaning touch system and private hydromassage bathtub"
// /// image : [{"_id":11,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F3.jpg?alt=media&token=a7f27b46-211f-46fc-a689-af797ad3bcc4","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null},{"_id":12,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F2.jpg?alt=media&token=db35f435-2bb1-46f5-8e13-2686086e92b8","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null},{"_id":13,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F15.jpg?alt=media&token=5713f4fc-8559-4fde-82c4-10d34b5b07d6","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null},{"_id":14,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F14.jpg?alt=media&token=4fe38e88-a697-41f7-8e02-d884dec066e9","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null},{"_id":15,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F14.jpg?alt=media&token=4fe38e88-a697-41f7-8e02-d884dec066e9","hotel_id":1,"room_id":103,"tour_id":null,"user_id":null}]
//
// RoomType roomTypeFromJson(String str) => RoomType.fromJson(json.decode(str));
//
// String roomTypeToJson(RoomType data) => json.encode(data.toJson());
//
// class RoomType {
//   RoomType({
//     int? roomId,
//     String? roomType,
//     String? roomSize,
//     String? bedSize,
//     int? maxCapacity,
//     int? price,
//     List<String>? features,
//     String? description,
//     List<Images>? image,
//   }) {
//     _roomId = roomId;
//     _roomType = roomType;
//     _roomSize = roomSize;
//     _bedSize = bedSize;
//     _maxCapacity = maxCapacity;
//     _price = price;
//     _features = features;
//     _description = description;
//     _image = image;
//   }
//
//   RoomType.fromJson(dynamic json) {
//     _roomId = json['room_id'];
//     _roomType = json['room_type'];
//     _roomSize = json['room_size'];
//     _bedSize = json['bed_size'];
//     _maxCapacity = json['max_capacity'];
//     _price = json['price'];
//     _features = json['features'] != null ? json['features'].cast<String>() : [];
//     _description = json['description'];
//     if (json['image'] != null) {
//       _image = [];
//       json['image'].forEach((v) {
//         _image?.add(Images.fromJson(v));
//       });
//     }
//   }
//
//   int? _roomId;
//   String? _roomType;
//   String? _roomSize;
//   String? _bedSize;
//   int? _maxCapacity;
//   int? _price;
//   List<String>? _features;
//   String? _description;
//   List<Images>? _image;
//
//   RoomType copyWith({
//     int? roomId,
//     String? roomType,
//     String? roomSize,
//     String? bedSize,
//     int? maxCapacity,
//     int? price,
//     List<String>? features,
//     String? description,
//     List<Images>? image,
//   }) =>
//       RoomType(
//         roomId: roomId ?? _roomId,
//         roomType: roomType ?? _roomType,
//         roomSize: roomSize ?? _roomSize,
//         bedSize: bedSize ?? _bedSize,
//         maxCapacity: maxCapacity ?? _maxCapacity,
//         price: price ?? _price,
//         features: features ?? _features,
//         description: description ?? _description,
//         image: image ?? _image,
//       );
//
//   int? get roomId => _roomId;
//
//   String? get roomType => _roomType;
//
//   String? get roomSize => _roomSize;
//
//   String? get bedSize => _bedSize;
//
//   int? get maxCapacity => _maxCapacity;
//
//   int? get price => _price;
//
//   List<String>? get features => _features;
//
//   String? get description => _description;
//
//   List<Images>? get image => _image;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['room_id'] = _roomId;
//     map['room_type'] = _roomType;
//     map['room_size'] = _roomSize;
//     map['bed_size'] = _bedSize;
//     map['max_capacity'] = _maxCapacity;
//     map['price'] = _price;
//     map['features'] = _features;
//     map['description'] = _description;
//     if (_image != null) {
//       map['image'] = _image?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }
//
// /// _id : 11
// /// image_url : "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/room%20images%2Fsemi%20delux%20room%2F3.jpg?alt=media&token=a7f27b46-211f-46fc-a689-af797ad3bcc4"
// /// hotel_id : 1
// /// room_id : 103
// /// tour_id : null
// /// user_id : null
//
// Images imagesFromJson(String str) => Images.fromJson(json.decode(str));
//
// String imagesToJson(Images data) => json.encode(data.toJson());
//
// class Images {
//   Images({
//     int? id,
//     String? imageUrl,
//     int? hotelId,
//     int? roomId,
//     dynamic tourId,
//     dynamic userId,
//   }) {
//     _id = id;
//     _imageUrl = imageUrl;
//     _hotelId = hotelId;
//     _roomId = roomId;
//     _tourId = tourId;
//     _userId = userId;
//   }
//
//   Images.fromJson(dynamic json) {
//     _id = json['_id'];
//     _imageUrl = json['image_url'];
//     _hotelId = json['hotel_id'];
//     _roomId = json['room_id'];
//     _tourId = json['tour_id'];
//     _userId = json['user_id'];
//   }
//
//   int? _id;
//   String? _imageUrl;
//   int? _hotelId;
//   int? _roomId;
//   dynamic _tourId;
//   dynamic _userId;
//
//   Images copyWith({
//     int? id,
//     String? imageUrl,
//     int? hotelId,
//     int? roomId,
//     dynamic tourId,
//     dynamic userId,
//   }) =>
//       Images(
//         id: id ?? _id,
//         imageUrl: imageUrl ?? _imageUrl,
//         hotelId: hotelId ?? _hotelId,
//         roomId: roomId ?? _roomId,
//         tourId: tourId ?? _tourId,
//         userId: userId ?? _userId,
//       );
//
//   int? get id => _id;
//
//   String? get imageUrl => _imageUrl;
//
//   int? get hotelId => _hotelId;
//
//   int? get roomId => _roomId;
//
//   dynamic get tourId => _tourId;
//
//   dynamic get userId => _userId;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['_id'] = _id;
//     map['image_url'] = _imageUrl;
//     map['hotel_id'] = _hotelId;
//     map['room_id'] = _roomId;
//     map['tour_id'] = _tourId;
//     map['user_id'] = _userId;
//     return map;
//   }
// }
//
//  // class RoomCategoryModel {
//  //   String? hotelId;
//  //   String? hotelName;
//  //   List<Deluxe>? deluxe;
//  //   List<SemiDeluxe>? semiDeluxe;
//  //   List<SuperDeluxe>? superDeluxe;
//  //
//  //   RoomCategoryModel(
//  //       {this.hotelId,
//  //         this.hotelName,
//  //         this.deluxe,
//  //         this.semiDeluxe,
//  //         this.superDeluxe});
//  //
//  //   RoomCategoryModel.fromJson(Map<String, dynamic> json) {
//  //     hotelId = json['hotel_id'];
//  //     hotelName = json['hotel_name'];
//  //     if (json['deluxe'] != null) {
//  //       deluxe = <Deluxe>[];
//  //       json['deluxe'].forEach((v) {
//  //         deluxe!.add(new Deluxe.fromJson(v));
//  //       });
//  //     }
//  //     if (json['semi-deluxe'] != null) {
//  //       semiDeluxe = <SemiDeluxe>[];
//  //       json['semi-deluxe'].forEach((v) {
//  //         semiDeluxe!.add(new SemiDeluxe.fromJson(v));
//  //       });
//  //     }
//  //     if (json['super-deluxe'] != null) {
//  //       superDeluxe = <SuperDeluxe>[];
//  //       json['super-deluxe'].forEach((v) {
//  //         superDeluxe!.add(new SuperDeluxe.fromJson(v));
//  //       });
//  //     }
//  //   }
//  //
//  //   Map<String, dynamic> toJson() {
//  //     final Map<String, dynamic> data = new Map<String, dynamic>();
//  //     data['hotel_id'] = this.hotelId;
//  //     data['hotel_name'] = this.hotelName;
//  //     if (this.deluxe != null) {
//  //       data['deluxe'] = this.deluxe!.map((v) => v.toJson()).toList();
//  //     }
//  //     if (this.semiDeluxe != null) {
//  //       data['semi-deluxe'] = this.semiDeluxe!.map((v) => v.toJson()).toList();
//  //     }
//  //     if (this.superDeluxe != null) {
//  //       data['super-deluxe'] = this.superDeluxe!.map((v) => v.toJson()).toList();
//  //     }
//  //     return data;
//  //   }
//  // }
//  //
//  // class Deluxe {
//  //   int? roomId;
//  //   String? roomType;
//  //   String? roomSize;
//  //   String? bedSize;
//  //   int? maxCapacity;
//  //   int? price;
//  //   List<String>? features;
//  //   String? description;
//  //   List<Image>? image;
//  //
//  //   Deluxe(
//  //       {this.roomId,
//  //         this.roomType,
//  //         this.roomSize,
//  //         this.bedSize,
//  //         this.maxCapacity,
//  //         this.price,
//  //         this.features,
//  //         this.description,
//  //         this.image});
//  //
//  //   Deluxe.fromJson(Map<String, dynamic> json) {
//  //     roomId = json['room_id'];
//  //     roomType = json['room_type'];
//  //     roomSize = json['room_size'];
//  //     bedSize = json['bed_size'];
//  //     maxCapacity = json['max_capacity'];
//  //     price = json['price'];
//  //     features = json['features'].cast<String>();
//  //     description = json['description'];
//  //     if (json['image'] != null) {
//  //       image = <Image>[];
//  //       json['image'].forEach((v) {
//  //         image!.add(new Image.fromJson(v));
//  //       });
//  //     }
//  //   }
//  //
//  //   Map<String, dynamic> toJson() {
//  //     final Map<String, dynamic> data = new Map<String, dynamic>();
//  //     data['room_id'] = this.roomId;
//  //     data['room_type'] = this.roomType;
//  //     data['room_size'] = this.roomSize;
//  //     data['bed_size'] = this.bedSize;
//  //     data['max_capacity'] = this.maxCapacity;
//  //     data['price'] = this.price;
//  //     data['features'] = this.features;
//  //     data['description'] = this.description;
//  //     if (this.image != null) {
//  //       data['image'] = this.image!.map((v) => v.toJson()).toList();
//  //     }
//  //     return data;
//  //   }
//  // }
//  //
//  // class Image {
//  //   int? iId;
//  //   String? imageUrl;
//  //   int? hotelId;
//  //   int? roomId;
//  //   Null? tourId;
//  //   Null? userId;
//  //
//  //   Image(
//  //       {this.iId,
//  //         this.imageUrl,
//  //         this.hotelId,
//  //         this.roomId,
//  //         this.tourId,
//  //         this.userId});
//  //
//  //   Image.fromJson(Map<String, dynamic> json) {
//  //     iId = json['_id'];
//  //     imageUrl = json['image_url'];
//  //     hotelId = json['hotel_id'];
//  //     roomId = json['room_id'];
//  //     tourId = json['tour_id'];
//  //     userId = json['user_id'];
//  //   }
//  //
//  //   Map<String, dynamic> toJson() {
//  //     final Map<String, dynamic> data = new Map<String, dynamic>();
//  //     data['_id'] = this.iId;
//  //     data['image_url'] = this.imageUrl;
//  //     data['hotel_id'] = this.hotelId;
//  //     data['room_id'] = this.roomId;
//  //     data['tour_id'] = this.tourId;
//  //     data['user_id'] = this.userId;
//  //     return data;
//  //   }
//  // }

 class RoomCategoryModel {
   String? hotelId;
   String? hotelName;
   List<Deluxe>? deluxe;
   List<SemiDeluxe>? semiDeluxe;
   List<SuperDeluxe>? superDeluxe;

   RoomCategoryModel(
       {this.hotelId,
         this.hotelName,
         this.deluxe,
         this.semiDeluxe,
         this.superDeluxe});

   RoomCategoryModel.fromJson(Map<String, dynamic> json) {
     hotelId = json['hotel_id'];
     hotelName = json['hotel_name'];
     if (json['deluxe'] != null) {
       deluxe = <Deluxe>[];
       json['deluxe'].forEach((v) {
         deluxe!.add(new Deluxe.fromJson(v));
       });
     }
     if (json['semi-deluxe'] != null) {
       semiDeluxe = <SemiDeluxe>[];
       json['semi-deluxe'].forEach((v) {
         semiDeluxe!.add(new SemiDeluxe.fromJson(v));
       });
     }
     if (json['super-deluxe'] != null) {
       superDeluxe = <SuperDeluxe>[];
       json['super-deluxe'].forEach((v) {
         superDeluxe!.add(new SuperDeluxe.fromJson(v));
       });
     }
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['hotel_id'] = this.hotelId;
     data['hotel_name'] = this.hotelName;
     if (this.deluxe != null) {
       data['deluxe'] = this.deluxe!.map((v) => v.toJson()).toList();
     }
     if (this.semiDeluxe != null) {
       data['semi-deluxe'] = this.semiDeluxe!.map((v) => v.toJson()).toList();
     }
     if (this.superDeluxe != null) {
       data['super-deluxe'] = this.superDeluxe!.map((v) => v.toJson()).toList();
     }
     return data;
   }
 }

 class Deluxe {
   int? roomId;
   String? roomType;
   String? roomSize;
   String? bedSize;
   int? maxCapacity;
   int? price;
   List<String>? features;
   String? description;
   List<Images>? image;

   Deluxe(
       {this.roomId,
         this.roomType,
         this.roomSize,
         this.bedSize,
         this.maxCapacity,
         this.price,
         this.features,
         this.description,
         this.image});

   Deluxe.fromJson(Map<String, dynamic> json) {
     roomId = json['room_id'];
     roomType = json['room_type'];
     roomSize = json['room_size'];
     bedSize = json['bed_size'];
     maxCapacity = json['max_capacity'];
     price = json['price'];
     features = json['features'].cast<String>();
     description = json['description'];
     if (json['image'] != null) {
       image = <Images>[];
       json['image'].forEach((v) {
         image!.add(new Images.fromJson(v));
       });
     }
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['room_id'] = this.roomId;
     data['room_type'] = this.roomType;
     data['room_size'] = this.roomSize;
     data['bed_size'] = this.bedSize;
     data['max_capacity'] = this.maxCapacity;
     data['price'] = this.price;
     data['features'] = this.features;
     data['description'] = this.description;
     if (this.image != null) {
       data['image'] = this.image!.map((v) => v.toJson()).toList();
     }
     return data;
   }
 }

 class SemiDeluxe {
   int? roomId;
   String? roomType;
   String? roomSize;
   String? bedSize;
   int? maxCapacity;
   int? price;
   List<String>? features;
   String? description;
   List<Images>? image;

   SemiDeluxe(
       {this.roomId,
         this.roomType,
         this.roomSize,
         this.bedSize,
         this.maxCapacity,
         this.price,
         this.features,
         this.description,
         this.image});

   SemiDeluxe.fromJson(Map<String, dynamic> json) {
     roomId = json['room_id'];
     roomType = json['room_type'];
     roomSize = json['room_size'];
     bedSize = json['bed_size'];
     maxCapacity = json['max_capacity'];
     price = json['price'];
     features = json['features'].cast<String>();
     description = json['description'];
     if (json['image'] != null) {
       image = <Images>[];
       json['image'].forEach((v) {
         image!.add(new Images.fromJson(v));
       });
     }
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['room_id'] = this.roomId;
     data['room_type'] = this.roomType;
     data['room_size'] = this.roomSize;
     data['bed_size'] = this.bedSize;
     data['max_capacity'] = this.maxCapacity;
     data['price'] = this.price;
     data['features'] = this.features;
     data['description'] = this.description;
     if (this.image != null) {
       data['image'] = this.image!.map((v) => v.toJson()).toList();
     }
     return data;
   }
 }

 class SuperDeluxe {
   int? roomId;
   String? roomType;
   String? roomSize;
   String? bedSize;
   int? maxCapacity;
   int? price;
   List<String>? features;
   String? description;
   List<Images>? image;

   SuperDeluxe(
       {this.roomId,
         this.roomType,
         this.roomSize,
         this.bedSize,
         this.maxCapacity,
         this.price,
         this.features,
         this.description,
         this.image});

   SuperDeluxe.fromJson(Map<String, dynamic> json) {
     roomId = json['room_id'];
     roomType = json['room_type'];
     roomSize = json['room_size'];
     bedSize = json['bed_size'];
     maxCapacity = json['max_capacity'];
     price = json['price'];
     features = json['features'].cast<String>();
     description = json['description'];
     if (json['image'] != null) {
       image = <Images>[];
       json['image'].forEach((v) {
         image!.add(new Images.fromJson(v));
       });
     }
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['room_id'] = this.roomId;
     data['room_type'] = this.roomType;
     data['room_size'] = this.roomSize;
     data['bed_size'] = this.bedSize;
     data['max_capacity'] = this.maxCapacity;
     data['price'] = this.price;
     data['features'] = this.features;
     data['description'] = this.description;
     if (this.image != null) {
       data['image'] = this.image!.map((v) => v.toJson()).toList();
     }
     return data;
   }
 }
 class Images {
   int? iId;
   String? imageUrl;
   int? hotelId;
   int? roomId;
   Null? tourId;
   Null? userId;

   Images(
       {this.iId,
         this.imageUrl,
         this.hotelId,
         this.roomId,
         this.tourId,
         this.userId});

   Images.fromJson(Map<String, dynamic> json) {
     iId = json['_id'];
     imageUrl = json['image_url'];
     hotelId = json['hotel_id'];
     roomId = json['room_id'];
     tourId = json['tour_id'];
     userId = json['user_id'];
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['_id'] = this.iId;
     data['image_url'] = this.imageUrl;
     data['hotel_id'] = this.hotelId;
     data['room_id'] = this.roomId;
     data['tour_id'] = this.tourId;
     data['user_id'] = this.userId;
     return data;
   }
 }