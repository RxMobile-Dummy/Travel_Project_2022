class HotelListModel {
  HotelListModel({
    int? id,
    int? hotelId,
    String? hotelName,
    int? rating,
    Address? address,
    int? price,
    List<Images>? images,
  }) {
    _id = id;
    _hotelId = hotelId;
    _hotelName = hotelName;
    _rating = rating;
    _address = address;
    _price = price;
    _images = images;
  }

  HotelListModel.fromJson(dynamic json) {
    _id = json['_id'];
    _hotelId = json['hotel_id'];
    _hotelName = json['hotel_name'];
    _rating = json['rating'];
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    _price = json['price'];
    if (json['Images'] != null) {
      _images = [];
      json['Images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
  }
  int? _id;
  int? _hotelId;
  String? _hotelName;
  int? _rating;
  Address? _address;
  int? _price;
  List<Images>? _images;
  HotelListModel copyWith({
    int? id,
    int? hotelId,
    String? hotelName,
    int? rating,
    Address? address,
    int? price,
    List<Images>? images,
  }) =>
      HotelListModel(
        id: id ?? _id,
        hotelId: hotelId ?? _hotelId,
        hotelName: hotelName ?? _hotelName,
        rating: rating ?? _rating,
        address: address ?? _address,
        price: price ?? _price,
        images: images ?? _images,
      );
  int? get id => _id;
  int? get hotelId => _hotelId;
  String? get hotelName => _hotelName;
  int? get rating => _rating;
  Address? get address => _address;
  int? get price => _price;
  List<Images>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['hotel_id'] = _hotelId;
    map['hotel_name'] = _hotelName;
    map['rating'] = _rating;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['price'] = _price;
    if (_images != null) {
      map['Images'] = _images?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : 36
/// image_url : "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F12.jpg?alt=media&token=817b5b0a-4acf-4030-8842-027578f5c105"
/// hotel_id : 2
/// room_id : null
/// tour_id : null
/// user_id : null
class Images {
  Images({
    int? id,
    String? imageUrl,
    int? hotelId,
    dynamic roomId,
    dynamic tourId,
    dynamic userId,
  }) {
    _id = id;
    _imageUrl = imageUrl;
    _hotelId = hotelId;
    _roomId = roomId;
    _tourId = tourId;
    _userId = userId;
  }

  Images.fromJson(dynamic json) {
    _id = json['_id'];
    _imageUrl = json['image_url'];
    _hotelId = json['hotel_id'];
    _roomId = json['room_id'];
    _tourId = json['tour_id'];
    _userId = json['user_id'];
  }
  int? _id;
  String? _imageUrl;
  int? _hotelId;
  dynamic _roomId;
  dynamic _tourId;
  dynamic _userId;
  Images copyWith({
    int? id,
    String? imageUrl,
    int? hotelId,
    dynamic roomId,
    dynamic tourId,
    dynamic userId,
  }) =>
      Images(
        id: id ?? _id,
        imageUrl: imageUrl ?? _imageUrl,
        hotelId: hotelId ?? _hotelId,
        roomId: roomId ?? _roomId,
        tourId: tourId ?? _tourId,
        userId: userId ?? _userId,
      );
  int? get id => _id;
  String? get imageUrl => _imageUrl;
  int? get hotelId => _hotelId;
  dynamic get roomId => _roomId;
  dynamic get tourId => _tourId;
  dynamic get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['image_url'] = _imageUrl;
    map['hotel_id'] = _hotelId;
    map['room_id'] = _roomId;
    map['tour_id'] = _tourId;
    map['user_id'] = _userId;
    return map;
  }
}

/// address_line : "Behind Ganesh Meridian Complex Sola Road, Sarkhej - Gandhinagar Hwy, Ahmedabad, Gujarat 380060"
/// city_id : 69
/// pincode : 380060
/// location : {"latitude":23.07526,"longitude":72.5267243}
class Address {
  Address({
    String? addressLine,
    int? cityId,
    int? pincode,
    Location? location,
  }) {
    _addressLine = addressLine;
    _cityId = cityId;
    _pincode = pincode;
    _location = location;
  }

  Address.fromJson(dynamic json) {
    _addressLine = json['address_line'];
    _cityId = json['city_id'];
    _pincode = json['pincode'];
    _location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }
  String? _addressLine;
  int? _cityId;
  int? _pincode;
  Location? _location;
  Address copyWith({
    String? addressLine,
    int? cityId,
    int? pincode,
    Location? location,
  }) =>
      Address(
        addressLine: addressLine ?? _addressLine,
        cityId: cityId ?? _cityId,
        pincode: pincode ?? _pincode,
        location: location ?? _location,
      );
  String? get addressLine => _addressLine;
  int? get cityId => _cityId;
  int? get pincode => _pincode;
  Location? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_line'] = _addressLine;
    map['city_id'] = _cityId;
    map['pincode'] = _pincode;
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    return map;
  }
}

/// latitude : 23.07526
/// longitude : 72.5267243
class Location {
  Location({
    double? latitude,
    double? longitude,
  }) {
    _latitude = latitude;
    _longitude = longitude;
  }

  Location.fromJson(dynamic json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }
  double? _latitude;
  double? _longitude;
  Location copyWith({
    double? latitude,
    double? longitude,
  }) =>
      Location(
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
      );
  double? get latitude => _latitude;
  double? get longitude => _longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }
}
