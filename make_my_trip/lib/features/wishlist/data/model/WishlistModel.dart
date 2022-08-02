import 'dart:convert';
/// _id : 5
/// hotel_id : 12
/// hotel_name : "Hotel The Royal Plaza"
/// address : {"location":{"latitude":"28.621386","longitude":"77.2174032"},"address_line":"19, Ashoka Rd, Janpath, Connaught Place, New Delhi, Delhi, India 110001","city_id":67,"pincode":110001}
/// price : 3541
/// wishListImage : [{"_id":226,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F83.jpg?alt=media&token=ee4bf1de-7585-4964-8c99-0deb2b72104a","hotel_id":12,"room_id":null,"tour_id":null,"user_id":null},{"_id":227,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F82.jpg?alt=media&token=940adafd-e2c5-4e54-a507-221a8c345a74","hotel_id":12,"room_id":null,"tour_id":null,"user_id":null},{"_id":228,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F81.jpg?alt=media&token=760b1ff5-ad13-480b-82fa-b4d86f54d3ba","hotel_id":12,"room_id":null,"tour_id":null,"user_id":null},{"_id":229,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F80.jpg?alt=media&token=44e12ead-843c-4db6-a4d4-7c0d0985327f","hotel_id":12,"room_id":null,"tour_id":null,"user_id":null},{"_id":230,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F8.jpg?alt=media&token=2d75c113-b0f4-4478-9e7b-e6454f0fbdfd","hotel_id":12,"room_id":null,"tour_id":null,"user_id":null}]

WishlistModel wishlistModelFromJson(String str) => WishlistModel.fromJson(json.decode(str));
String wishlistModelToJson(WishlistModel data) => json.encode(data.toJson());
class WishlistModel {
  WishlistModel({
      this.id, 
      this.hotelId, 
      this.hotelName, 
      this.address, 
      this.price, 
      this.wishListImage,});

  WishlistModel.fromJson(dynamic json) {
    id = json['_id'];
    hotelId = json['hotel_id'];
    hotelName = json['hotel_name'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    price = json['price'];
    if (json['wishListImage'] != null) {
      wishListImage = [];
      json['wishListImage'].forEach((v) {
        wishListImage?.add(WishListImage.fromJson(v));
      });
    }
  }
  int? id;
  int? hotelId;
  String? hotelName;
  Address? address;
  int? price;
  List<WishListImage>? wishListImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['hotel_id'] = hotelId;
    map['hotel_name'] = hotelName;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    map['price'] = price;
    if (wishListImage != null) {
      map['wishListImage'] = wishListImage?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : 226
/// image_url : "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F83.jpg?alt=media&token=ee4bf1de-7585-4964-8c99-0deb2b72104a"
/// hotel_id : 12
/// room_id : null
/// tour_id : null
/// user_id : null

WishListImage wishListImageFromJson(String str) => WishListImage.fromJson(json.decode(str));
String wishListImageToJson(WishListImage data) => json.encode(data.toJson());
class WishListImage {
  WishListImage({
      this.id, 
      this.imageUrl, 
      this.hotelId, 
      this.roomId, 
      this.tourId, 
      this.userId,});

  WishListImage.fromJson(dynamic json) {
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
  dynamic roomId;
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

/// location : {"latitude":"28.621386","longitude":"77.2174032"}
/// address_line : "19, Ashoka Rd, Janpath, Connaught Place, New Delhi, Delhi, India 110001"
/// city_id : 67
/// pincode : 110001

Address addressFromJson(String str) => Address.fromJson(json.decode(str));
String addressToJson(Address data) => json.encode(data.toJson());
class Address {
  Address({
      this.location, 
      this.addressLine, 
      this.cityId, 
      this.pincode,});

  Address.fromJson(dynamic json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    addressLine = json['address_line'];
    cityId = json['city_id'];
    pincode = json['pincode'];
  }
  Location? location;
  String? addressLine;
  int? cityId;
  int? pincode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['address_line'] = addressLine;
    map['city_id'] = cityId;
    map['pincode'] = pincode;
    return map;
  }

}

/// latitude : "28.621386"
/// longitude : "77.2174032"

Location locationFromJson(String str) => Location.fromJson(json.decode(str));
String locationToJson(Location data) => json.encode(data.toJson());
class Location {
  Location({
      this.latitude, 
      this.longitude,});

  Location.fromJson(dynamic json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
  String? latitude;
  String? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }

}