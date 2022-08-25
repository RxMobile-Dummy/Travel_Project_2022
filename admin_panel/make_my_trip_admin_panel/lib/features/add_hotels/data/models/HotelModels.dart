import 'dart:convert';
/// _id : 7
/// hotel_id : 7
/// hotel_name : "Taj Lands End, Mumbai"
/// rating : 2.4
/// address : {"address_line":"Band Stand, BJ Road, Mount Mary, Bandra West, Mumbai, Maharashtra, India 400050","city_id":115,"pincode":400050,"location":{"latitude":19.0435344,"longitude":72.82021639999999}}
/// price : 11700
/// Images : [{"_id":128,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F73.jpg?alt=media&token=7040bd55-261f-41f1-95e7-2c06a90ddbdb","hotel_id":7,"room_id":null,"tour_id":null,"user_id":null},{"_id":127,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F72.jpg?alt=media&token=bf55b364-7ab8-47b9-ab8f-0cbde04e61dd","hotel_id":7,"room_id":null,"tour_id":null,"user_id":null},{"_id":130,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F75.jpg?alt=media&token=d50f4b1c-f93b-4066-8477-85f3cb9c05bc","hotel_id":7,"room_id":null,"tour_id":null,"user_id":null},{"_id":126,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F71.jpg?alt=media&token=15ac1fb0-c558-4bde-a024-20c5f4ccd1dd","hotel_id":7,"room_id":null,"tour_id":null,"user_id":null},{"_id":129,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F74.jpg?alt=media&token=4f4184ed-4787-4ee0-ac02-61c1dda7749d","hotel_id":7,"room_id":null,"tour_id":null,"user_id":null}]

HotelModels hotelModelsFromJson(String str) => HotelModels.fromJson(json.decode(str));
String hotelModelsToJson(HotelModels data) => json.encode(data.toJson());
class HotelModels {
  HotelModels({
      this.id, 
      this.hotelId,
      this.hotelName, 
      this.rating, 
      this.address, 
      this.price, 
      this.images,});

  HotelModels.fromJson(dynamic json) {
    id = json['_id'];
    hotelId = json['hotel_id'];
    hotelName = json['hotel_name'];
    rating = json['rating'];
    address = json['address'] != null ? Addres.fromJson(json['address']) : null;
    price = json['price'];
    if (json['Images'] != null) {
      images = [];
      json['Images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
  }
  num? id;
  num? hotelId;
  String? hotelName;
  num? rating;
  Addres? address;
  num? price;
  List<Images>? images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['hotel_id'] = hotelId;
    map['hotel_name'] = hotelName;
    map['rating'] = rating;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    map['price'] = price;
    if (images != null) {
      map['Images'] = images?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : 128
/// image_url : "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F73.jpg?alt=media&token=7040bd55-261f-41f1-95e7-2c06a90ddbdb"
/// hotel_id : 7
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
  num? id;
  String? imageUrl;
  num? hotelId;
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

/// address_line : "Band Stand, BJ Road, Mount Mary, Bandra West, Mumbai, Maharashtra, India 400050"
/// city_id : 115
/// pincode : 400050
/// location : {"latitude":19.0435344,"longitude":72.82021639999999}

Addres addressFromJson(String str) => Addres.fromJson(json.decode(str));
String addressToJson(Addres data) => json.encode(data.toJson());
class Addres {
  Addres({
      this.addressLine, 
      this.cityId, 
      this.pincode, 
      this.location,});

  Addres.fromJson(dynamic json) {
    addressLine = json['address_line'];
    cityId = json['city_id'];
    pincode = json['pincode'];
    location = json['location'] != null ? Locations.fromJson(json['location']) : null;
  }
  String? addressLine;
  num? cityId;
  num? pincode;
  Locations? location;

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

/// latitude : 19.0435344
/// longitude : 72.82021639999999

Locations locationFromJson(String str) => Locations.fromJson(json.decode(str));
String locationToJson(Locations data) => json.encode(data.toJson());
class Locations {
  Locations({
      this.latitude, 
      this.longitude,});

  Locations.fromJson(dynamic json) {
    latitude = (json['latitude']);
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