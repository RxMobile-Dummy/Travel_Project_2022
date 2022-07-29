import 'dart:convert';
/// hotel_id : 1
/// hotel_name : "Hotel Khyber Palace"
/// address : {"address_line":"Sanand Cir, Sarkhej, Ahmedabad, Gujarat, India 382210","pincode":382210,"city_id":69,"location":{"longitude":23.0609355,"latitude":72.4483075}}
/// images : [{"_id":16,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F1.jpg?alt=media&token=3148b5f2-af26-4094-8c7c-59dd4c5c9a5f","hotel_id":1,"room_id":null,"tour_id":null,"user_id":null},{"_id":17,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F10.jpg?alt=media&token=957ff0b4-4e9d-49c7-a073-5acee6718bf9","hotel_id":1,"room_id":null,"tour_id":null,"user_id":null},{"_id":18,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F100.jpg?alt=media&token=95abd6b8-d27e-4f3f-93bb-984175b41beb","hotel_id":1,"room_id":null,"tour_id":null,"user_id":null},{"_id":19,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F11.jpg?alt=media&token=800ca785-fab3-4b52-8f48-f050aece4d48","hotel_id":1,"room_id":null,"tour_id":null,"user_id":null},{"_id":20,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F11.png?alt=media&token=3f2d0a99-891e-4151-bd51-6235685d5b6f","hotel_id":1,"room_id":null,"tour_id":null,"user_id":null}]
/// price : 11880
/// checking_date : "2022-01-08T00:00:00.000Z"
/// checkout_date : "2022-01-10T00:00:00.000Z"

UserHistoryModel userHistoryModelFromJson(String str) => UserHistoryModel.fromJson(json.decode(str));
String userHistoryModelToJson(UserHistoryModel data) => json.encode(data.toJson());
class UserHistoryModel {
  UserHistoryModel({
      this.hotelId, 
      this.hotelName, 
      this.address, 
      this.images, 
      this.price, 
      this.checkingDate, 
      this.checkoutDate,});

  UserHistoryModel.fromJson(dynamic json) {
    hotelId = json['hotel_id'];
    hotelName = json['hotel_name'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    price = double.parse(json['price'].toString());
    checkingDate = json['checking_date'];
    checkoutDate = json['checkout_date'];
  }
  int? hotelId;
  String? hotelName;
  Address? address;
  List<Images>? images;
  double? price;
  String? checkingDate;
  String? checkoutDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hotel_id'] = hotelId;
    map['hotel_name'] = hotelName;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    map['price'] = price;
    map['checking_date'] = checkingDate;
    map['checkout_date'] = checkoutDate;
    return map;
  }

}

/// _id : 16
/// image_url : "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F1.jpg?alt=media&token=3148b5f2-af26-4094-8c7c-59dd4c5c9a5f"
/// hotel_id : 1
/// room_id : null
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
      this.userId,});

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

/// address_line : "Sanand Cir, Sarkhej, Ahmedabad, Gujarat, India 382210"
/// pincode : 382210
/// city_id : 69
/// location : {"longitude":23.0609355,"latitude":72.4483075}

Address addressFromJson(String str) => Address.fromJson(json.decode(str));
String addressToJson(Address data) => json.encode(data.toJson());
class Address {
  Address({
      this.addressLine, 
      this.pincode, 
      this.cityId, 
      this.location,});

  Address.fromJson(dynamic json) {
    addressLine = json['address_line'];
    pincode = json['pincode'];
    cityId = json['city_id'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
  }
  String? addressLine;
  int? pincode;
  int? cityId;
  Location? location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_line'] = addressLine;
    map['pincode'] = pincode;
    map['city_id'] = cityId;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    return map;
  }

}

/// longitude : 23.0609355
/// latitude : 72.4483075

Location locationFromJson(String str) => Location.fromJson(json.decode(str));
String locationToJson(Location data) => json.encode(data.toJson());
class Location {
  Location({
      this.longitude, 
      this.latitude,});

  Location.fromJson(dynamic json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }
  double? longitude;
  double? latitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    return map;
  }

}