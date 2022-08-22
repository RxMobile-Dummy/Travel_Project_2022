import 'dart:convert';

/// _id : 5
/// hotel_name : "Lemon Tree Hotel, Ahmedabad"
/// address : {"address_line":"434/1, Mithakhali Six, Vijay Cross Rd, Navrangpura, Ahmedabad, Gujarat 380006","city_id":69,"pincode":380006,"location":{"latitude":23.0296354,"longitude":72.5638695}}
/// rating : 5
/// price : 2703
/// phone_number : 7944232323
/// description : "The restaurant is named Patang, literally a fighter kite in Gujarati language. It was designed by an architect Hasmukh Patel.[5][6][4] The restaurant and the adjoining Chinubhai Centre, a commercial complex, were built in 1980–1984 at a cost of approximately ₹1.25 crore"
/// features : ["Parking","Healthy Breakfast","Transportation","Laundry","Entertainment"]
/// images : [{"_id":86,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F48.jpg?alt=media&token=181ae051-aef5-4858-804e-be8336e75f9c","hotel_id":5,"room_id":null,"tour_id":null,"user_id":null},{"_id":87,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F41.jpg?alt=media&token=e95d8ba7-0516-4778-856f-28bf8251b05c","hotel_id":5,"room_id":null,"tour_id":null,"user_id":null},{"_id":88,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F21.jpg?alt=media&token=0b473db2-9f81-41da-b177-bb16f6177b8f","hotel_id":5,"room_id":null,"tour_id":null,"user_id":null},{"_id":89,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F23.jpg?alt=media&token=f71a33fa-b99a-493c-86cf-da785a0c1577","hotel_id":5,"room_id":null,"tour_id":null,"user_id":null},{"_id":90,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F74.jpg?alt=media&token=4f4184ed-4787-4ee0-ac02-61c1dda7749d","hotel_id":5,"room_id":null,"tour_id":null,"user_id":null}]

HotelDetailModel hotelDetailModelFromJson(String str) =>
    HotelDetailModel.fromJson(json.decode(str));
String hotelDetailModelToJson(HotelDetailModel data) =>
    json.encode(data.toJson());

class HotelDetailModel {
  HotelDetailModel({
    this.id,
    this.hotelName,
    this.address,
    this.rating,
    this.price,
    this.phoneNumber,
    this.description,
    this.features,
    this.images,
    this.isbookmark,
  });

  HotelDetailModel.fromJson(dynamic json) {
    id = json['_id'];
    hotelName = json['hotel_name'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    rating = json['rating'];
    price = json['price'];
    phoneNumber = json['phone_number'];
    description = json['description'];
    features = json['features'] != null ? json['features'].cast<String>() : [];
    isbookmark = json['isbookmark'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
  }
  int? id;
  String? hotelName;
  Address? address;
  int? rating;
  int? price;
  int? phoneNumber;
  String? description;
  List<String>? features;
  List<Images>? images;
  bool? isbookmark;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['hotel_name'] = hotelName;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    map['rating'] = rating;
    map['price'] = price;
    map['phone_number'] = phoneNumber;
    map['description'] = description;
    map['features'] = features;
    map['isbookmark'] = isbookmark;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : 86
/// image_url : "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F48.jpg?alt=media&token=181ae051-aef5-4858-804e-be8336e75f9c"
/// hotel_id : 5
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

/// address_line : "434/1, Mithakhali Six, Vijay Cross Rd, Navrangpura, Ahmedabad, Gujarat 380006"
/// city_id : 69
/// pincode : 380006
/// location : {"latitude":23.0296354,"longitude":72.5638695}

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

/// latitude : 23.0296354
/// longitude : 72.5638695

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
