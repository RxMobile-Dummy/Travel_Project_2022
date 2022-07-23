import 'dart:convert';

/// _id : 9
/// hotel_name : "Hyatt Ahmedabad"
/// address : {"location":{"latitude":"23.0393464","longitude":"72.5306502"},"address_line":"Bodakdev Rd, next to Ahmedabad One Mall, Vastrapur, Ahmedabad, Gujarat, India 380015","city_id":69,"pincode":380015}
/// price : 5692
/// wishListImage : [{"_id":66,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F1.jpg?alt=media&token=3148b5f2-af26-4094-8c7c-59dd4c5c9a5f","hotel_id":4,"room_id":null,"tour_id":null,"user_id":null},{"_id":67,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F10.jpg?alt=media&token=957ff0b4-4e9d-49c7-a073-5acee6718bf9","hotel_id":4,"room_id":null,"tour_id":null,"user_id":null},{"_id":68,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F100.jpg?alt=media&token=95abd6b8-d27e-4f3f-93bb-984175b41beb","hotel_id":4,"room_id":null,"tour_id":null,"user_id":null},{"_id":69,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F11.jpg?alt=media&token=800ca785-fab3-4b52-8f48-f050aece4d48","hotel_id":4,"room_id":null,"tour_id":null,"user_id":null},{"_id":70,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F11.png?alt=media&token=3f2d0a99-891e-4151-bd51-6235685d5b6f","hotel_id":4,"room_id":null,"tour_id":null,"user_id":null}]

WishlistModel wishlistModelFromJson(String str) =>
    WishlistModel.fromJson(json.decode(str));
String wishlistModelToJson(WishlistModel data) => json.encode(data.toJson());

class WishlistModel {
  WishlistModel({
    this.id,
    this.hotelName,
    this.address,
    this.price,
    this.wishListImage,
  });

  WishlistModel.fromJson(dynamic json) {
    id = json['_id'];
    hotelName = json['hotel_name'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    price = json['price'];
    if (json['wishListImage'] != null) {
      wishListImage = [];
      json['wishListImage'].forEach((v) {
        wishListImage?.add(WishListImage.fromJson(v));
      });
    }
  }
  int? id;
  String? hotelName;
  Address? address;
  int? price;
  List<WishListImage>? wishListImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
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

/// _id : 66
/// image_url : "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F1.jpg?alt=media&token=3148b5f2-af26-4094-8c7c-59dd4c5c9a5f"
/// hotel_id : 4
/// room_id : null
/// tour_id : null
/// user_id : null

WishListImage wishListImageFromJson(String str) =>
    WishListImage.fromJson(json.decode(str));
String wishListImageToJson(WishListImage data) => json.encode(data.toJson());

class WishListImage {
  WishListImage({
    this.id,
    this.imageUrl,
    this.hotelId,
    this.roomId,
    this.tourId,
    this.userId,
  });

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

/// location : {"latitude":"23.0393464","longitude":"72.5306502"}
/// address_line : "Bodakdev Rd, next to Ahmedabad One Mall, Vastrapur, Ahmedabad, Gujarat, India 380015"
/// city_id : 69
/// pincode : 380015

Address addressFromJson(String str) => Address.fromJson(json.decode(str));
String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    this.location,
    this.addressLine,
    this.cityId,
    this.pincode,
  });

  Address.fromJson(dynamic json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
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

/// latitude : "23.0393464"
/// longitude : "72.5306502"

Location locationFromJson(String str) => Location.fromJson(json.decode(str));
String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  Location({
    this.latitude,
    this.longitude,
  });

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
