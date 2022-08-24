/// hotel_id : 27
/// hotel_name : "Fabhotels - Hotel Le Golden"
/// address : {"address_line":"Golden Tower, Clock Tower Extension, Opp, Amritsar, Punjab, India 143001","city_id":146,"pincode":143001,"location":{"latitude":31.6213916,"longitude":74.8764836}}
/// images : [{"_id":537,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F36.jpg?alt=media&token=07bc77ed-89b6-4320-826d-4c534d8cc521","hotel_id":27,"room_id":null,"tour_id":null,"user_id":null},{"_id":538,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F37.jpg?alt=media&token=ef8c2053-c747-4523-b80c-5e9a0c8af76f","hotel_id":27,"room_id":null,"tour_id":null,"user_id":null},{"_id":540,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F38.jpg?alt=media&token=86a75082-328e-4ce6-a119-624aa83160c0","hotel_id":27,"room_id":null,"tour_id":null,"user_id":null},{"_id":536,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F35.jpeg?alt=media&token=7b3df15c-5ab0-4b99-b9d7-4ecd01379a94","hotel_id":27,"room_id":null,"tour_id":null,"user_id":null},{"_id":539,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F38.jpg?alt=media&token=86a75082-328e-4ce6-a119-624aa83160c0","hotel_id":27,"room_id":null,"tour_id":null,"user_id":null}]
/// price : 34400
/// no_of_room : 1
/// number_of_nights : 5
/// room_price : 6000
/// discount : 5400
/// gst : 1000
/// booking_id : 16
/// status : "success"
/// booked_date : "2022-08-20T12:28:30.236Z"
/// checking_date : "2022-09-18T00:00:00.000Z"
/// checkout_date : "2022-09-23T00:00:00.000Z"

class UserHistoryModel {
  UserHistoryModel({
      int? hotelId,
      String? hotelName,
      Address? address,
      List<Images>? images,
      int? price,
      int? noOfRoom,
      int? numberOfNights,
      int? roomPrice,
      int? discount,
      int? gst,
      int? bookingId,
      String? status,
      String? bookedDate,
      String? checkingDate,
      String? checkoutDate,}){
    _hotelId = hotelId;
    _hotelName = hotelName;
    _address = address;
    _images = images;
    _price = price;
    _noOfRoom = noOfRoom;
    _numberOfNights = numberOfNights;
    _roomPrice = roomPrice;
    _discount = discount;
    _gst = gst;
    _bookingId = bookingId;
    _status = status;
    _bookedDate = bookedDate;
    _checkingDate = checkingDate;
    _checkoutDate = checkoutDate;
}

  UserHistoryModel.fromJson(dynamic json) {
    _hotelId = json['hotel_id'];
    _hotelName = json['hotel_name'];
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
    _price = json['price'];
    _noOfRoom = json['no_of_room'];
    _numberOfNights = json['number_of_nights'];
    _roomPrice = json['room_price'];
    _discount = json['discount'];
    _gst = json['gst'];
    _bookingId = json['booking_id'];
    _status = json['status'];
    _bookedDate = json['booked_date'];
    _checkingDate = json['checking_date'];
    _checkoutDate = json['checkout_date'];
  }
  int? _hotelId;
  String? _hotelName;
  Address? _address;
  List<Images>? _images;
  int? _price;
  int? _noOfRoom;
  int? _numberOfNights;
  int? _roomPrice;
  int? _discount;
  int? _gst;
  int? _bookingId;
  String? _status;
  String? _bookedDate;
  String? _checkingDate;
  String? _checkoutDate;
UserHistoryModel copyWith({  int? hotelId,
  String? hotelName,
  Address? address,
  List<Images>? images,
  int? price,
  int? noOfRoom,
  int? numberOfNights,
  int? roomPrice,
  int? discount,
  int? gst,
  int? bookingId,
  String? status,
  String? bookedDate,
  String? checkingDate,
  String? checkoutDate,
}) => UserHistoryModel(  hotelId: hotelId ?? _hotelId,
  hotelName: hotelName ?? _hotelName,
  address: address ?? _address,
  images: images ?? _images,
  price: price ?? _price,
  noOfRoom: noOfRoom ?? _noOfRoom,
  numberOfNights: numberOfNights ?? _numberOfNights,
  roomPrice: roomPrice ?? _roomPrice,
  discount: discount ?? _discount,
  gst: gst ?? _gst,
  bookingId: bookingId ?? _bookingId,
  status: status ?? _status,
  bookedDate: bookedDate ?? _bookedDate,
  checkingDate: checkingDate ?? _checkingDate,
  checkoutDate: checkoutDate ?? _checkoutDate,
);
  int? get hotelId => _hotelId;
  String? get hotelName => _hotelName;
  Address? get address => _address;
  List<Images>? get images => _images;
  int? get price => _price;
  int? get noOfRoom => _noOfRoom;
  int? get numberOfNights => _numberOfNights;
  int? get roomPrice => _roomPrice;
  int? get discount => _discount;
  int? get gst => _gst;
  int? get bookingId => _bookingId;
  String? get status => _status;
  String? get bookedDate => _bookedDate;
  String? get checkingDate => _checkingDate;
  String? get checkoutDate => _checkoutDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hotel_id'] = _hotelId;
    map['hotel_name'] = _hotelName;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    map['price'] = _price;
    map['no_of_room'] = _noOfRoom;
    map['number_of_nights'] = _numberOfNights;
    map['room_price'] = _roomPrice;
    map['discount'] = _discount;
    map['gst'] = _gst;
    map['booking_id'] = _bookingId;
    map['status'] = _status;
    map['booked_date'] = _bookedDate;
    map['checking_date'] = _checkingDate;
    map['checkout_date'] = _checkoutDate;
    return map;
  }

}

/// _id : 537
/// image_url : "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F36.jpg?alt=media&token=07bc77ed-89b6-4320-826d-4c534d8cc521"
/// hotel_id : 27
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
      dynamic userId,}){
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
Images copyWith({  int? id,
  String? imageUrl,
  int? hotelId,
  dynamic roomId,
  dynamic tourId,
  dynamic userId,
}) => Images(  id: id ?? _id,
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

/// address_line : "Golden Tower, Clock Tower Extension, Opp, Amritsar, Punjab, India 143001"
/// city_id : 146
/// pincode : 143001
/// location : {"latitude":31.6213916,"longitude":74.8764836}

class Address {
  Address({
      String? addressLine,
      int? cityId,
      int? pincode,
      Location? location,}){
    _addressLine = addressLine;
    _cityId = cityId;
    _pincode = pincode;
    _location = location;
}

  Address.fromJson(dynamic json) {
    _addressLine = json['address_line'];
    _cityId = json['city_id'];
    _pincode = json['pincode'];
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
  }
  String? _addressLine;
  int? _cityId;
  int? _pincode;
  Location? _location;
Address copyWith({  String? addressLine,
  int? cityId,
  int? pincode,
  Location? location,
}) => Address(  addressLine: addressLine ?? _addressLine,
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

/// latitude : 31.6213916
/// longitude : 74.8764836

class Location {
  Location({
      double? latitude,
      double? longitude,}){
    _latitude = latitude;
    _longitude = longitude;
}

  Location.fromJson(dynamic json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }
  double? _latitude;
  double? _longitude;
Location copyWith({  double? latitude,
  double? longitude,
}) => Location(  latitude: latitude ?? _latitude,
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