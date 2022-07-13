import 'dart:convert';

/// _id : 11
/// hotel_name : "The Lalit New Delhi"
/// address : {"address_line":"Fire Brigade Lane, Barakhamba, New Delhi, Delhi 110001","city_id":67,"pincode":110001,"location":{"latitude":28.6316615,"longitude":77.2272325}}
/// rating : 5
/// price : 6708
/// description : "This ritzy hotel is 2 blocks from lively Connaught Place, a 7-minute walk from the Shivaji Bridge railway station and 1.6 km from Jantar Mantar, an 18th-century astronomy complex."
/// images : [{"_id":206,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6","hotel_id":11,"user_id":null}]

HotelDetailModel hotelDetailModelFromJson(String str) =>
    HotelDetailModel.fromJson(json.decode(str));
String hotelDetailModelToJson(HotelDetailModel data) =>
    json.encode(data.toJson());

class HotelDetailModel {
  HotelDetailModel(
      {this.id,
      this.hotelName,
      this.address,
      this.rating,
      this.price,
      this.description,
      this.images,
      this.phoneNumber});

  HotelDetailModel.fromJson(dynamic json) {
    id = json['_id'];
    hotelName = json['hotel_name'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    rating = json['rating'];
    price = json['price'];
    description = json['description'];

    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    phoneNumber = json['phone_number'];
  }
  int? id;
  String? hotelName;
  Address? address;
  int? rating;
  int? price;
  String? description;
  List<Images>? images;
  int? phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['hotel_name'] = hotelName;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    map['rating'] = rating;
    map['price'] = price;
    map['description'] = description;
    map['phone_number'] = phoneNumber;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : 206
/// image_url : "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F40.jpg?alt=media&token=7d1337cc-b774-4503-ab8c-0b34e2e247f6"
/// hotel_id : 11
/// user_id : null

Images imagesFromJson(String str) => Images.fromJson(json.decode(str));
String imagesToJson(Images data) => json.encode(data.toJson());

class Images {
  Images({
    this.id,
    this.imageUrl,
    this.hotelId,
    this.userId,
  });

  Images.fromJson(dynamic json) {
    id = json['_id'];
    imageUrl = json['image_url'];
    hotelId = json['hotel_id'];
    userId = json['user_id'];
  }
  int? id;
  String? imageUrl;
  int? hotelId;
  dynamic userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['image_url'] = imageUrl;
    map['hotel_id'] = hotelId;
    map['user_id'] = userId;
    return map;
  }
}

/// address_line : "Fire Brigade Lane, Barakhamba, New Delhi, Delhi 110001"
/// city_id : 67
/// pincode : 110001
/// location : {"latitude":28.6316615,"longitude":77.2272325}

Address addressFromJson(String str) => Address.fromJson(json.decode(str));
String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    this.addressLine,
    this.cityId,
    this.pincode,
    this.location,
  });

  Address.fromJson(dynamic json) {
    addressLine = json['address_line'];
    cityId = json['city_id'];
    pincode = json['pincode'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }
  String? addressLine;
  int? cityId;
  int? pincode;
  Location? location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_line'] = addressLine;
    map['city_id'] = cityId;
    map['pincode'] = pincode;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    return map;
  }
}

/// latitude : 28.6316615
/// longitude : 77.2272325

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
  double? latitude;
  double? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }
}
