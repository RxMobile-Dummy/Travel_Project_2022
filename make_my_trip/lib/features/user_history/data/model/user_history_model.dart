/// booking_id : 27
/// status : "success"
/// hotel_id : 1
/// hotel_name : "Hotel Khyber Palace"
/// address : {"address_line":"Sanand Cir, Sarkhej, Ahmedabad, Gujarat, India 382210","pincode":382210,"city_id":69,"location":{"latitude":23.0609355,"longitude":72.4483075}}
/// images : [{"_id":16,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F1.jpg?alt=media&token=3148b5f2-af26-4094-8c7c-59dd4c5c9a5f","hotel_id":1,"room_id":null,"tour_id":null,"user_id":null},{"_id":17,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F10.jpg?alt=media&token=957ff0b4-4e9d-49c7-a073-5acee6718bf9","hotel_id":1,"room_id":null,"tour_id":null,"user_id":null},{"_id":20,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F11.png?alt=media&token=3f2d0a99-891e-4151-bd51-6235685d5b6f","hotel_id":1,"room_id":null,"tour_id":null,"user_id":null},{"_id":18,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F100.jpg?alt=media&token=95abd6b8-d27e-4f3f-93bb-984175b41beb","hotel_id":1,"room_id":null,"tour_id":null,"user_id":null},{"_id":19,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F11.jpg?alt=media&token=800ca785-fab3-4b52-8f48-f050aece4d48","hotel_id":1,"room_id":null,"tour_id":null,"user_id":null}]
/// price : 18496.5
/// no_of_room : 3
/// number_of_nights : 1
/// room_price : 16500
/// discount : 973.5
/// gst : 2970
/// booked_date : "2022-07-30T17:56:38.023Z"
/// checking_date : "2022-08-30T00:00:00.000Z"
/// checkout_date : "2022-08-31T00:00:00.000Z"

class UserHistoryModel {
  UserHistoryModel({
      int? bookingId, 
      String? status, 
      int? hotelId, 
      String? hotelName, 
      Address? address, 
      List<Images>? images, 
      double? price, 
      int? noOfRoom, 
      int? numberOfNights, 
      int? roomPrice, 
      double? discount, 
      int? gst, 
      String? bookedDate, 
      String? checkingDate, 
      String? checkoutDate,}){
    _bookingId = bookingId;
    _status = status;
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
    _bookedDate = bookedDate;
    _checkingDate = checkingDate;
    _checkoutDate = checkoutDate;
}

  UserHistoryModel.fromJson(dynamic json) {
    _bookingId = json['booking_id'];
    _status = json['status'];
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
    _bookedDate = json['booked_date'];
    _checkingDate = json['checking_date'];
    _checkoutDate = json['checkout_date'];
  }
  int? _bookingId;
  String? _status;
  int? _hotelId;
  String? _hotelName;
  Address? _address;
  List<Images>? _images;
  double? _price;
  int? _noOfRoom;
  int? _numberOfNights;
  int? _roomPrice;
  double? _discount;
  int? _gst;
  String? _bookedDate;
  String? _checkingDate;
  String? _checkoutDate;
UserHistoryModel copyWith({  int? bookingId,
  String? status,
  int? hotelId,
  String? hotelName,
  Address? address,
  List<Images>? images,
  double? price,
  int? noOfRoom,
  int? numberOfNights,
  int? roomPrice,
  double? discount,
  int? gst,
  String? bookedDate,
  String? checkingDate,
  String? checkoutDate,
}) => UserHistoryModel(  bookingId: bookingId ?? _bookingId,
  status: status ?? _status,
  hotelId: hotelId ?? _hotelId,
  hotelName: hotelName ?? _hotelName,
  address: address ?? _address,
  images: images ?? _images,
  price: price ?? _price,
  noOfRoom: noOfRoom ?? _noOfRoom,
  numberOfNights: numberOfNights ?? _numberOfNights,
  roomPrice: roomPrice ?? _roomPrice,
  discount: discount ?? _discount,
  gst: gst ?? _gst,
  bookedDate: bookedDate ?? _bookedDate,
  checkingDate: checkingDate ?? _checkingDate,
  checkoutDate: checkoutDate ?? _checkoutDate,
);
  int? get bookingId => _bookingId;
  String? get status => _status;
  int? get hotelId => _hotelId;
  String? get hotelName => _hotelName;
  Address? get address => _address;
  List<Images>? get images => _images;
  double? get price => _price;
  int? get noOfRoom => _noOfRoom;
  int? get numberOfNights => _numberOfNights;
  int? get roomPrice => _roomPrice;
  double? get discount => _discount;
  int? get gst => _gst;
  String? get bookedDate => _bookedDate;
  String? get checkingDate => _checkingDate;
  String? get checkoutDate => _checkoutDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['booking_id'] = _bookingId;
    map['status'] = _status;
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
    map['booked_date'] = _bookedDate;
    map['checking_date'] = _checkingDate;
    map['checkout_date'] = _checkoutDate;
    return map;
  }

}

/// _id : 16
/// image_url : "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F1.jpg?alt=media&token=3148b5f2-af26-4094-8c7c-59dd4c5c9a5f"
/// hotel_id : 1
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

/// address_line : "Sanand Cir, Sarkhej, Ahmedabad, Gujarat, India 382210"
/// pincode : 382210
/// city_id : 69
/// location : {"latitude":23.0609355,"longitude":72.4483075}

class Address {
  Address({
      String? addressLine, 
      int? pincode, 
      int? cityId, 
      Location? location,}){
    _addressLine = addressLine;
    _pincode = pincode;
    _cityId = cityId;
    _location = location;
}

  Address.fromJson(dynamic json) {
    _addressLine = json['address_line'];
    _pincode = json['pincode'];
    _cityId = json['city_id'];
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
  }
  String? _addressLine;
  int? _pincode;
  int? _cityId;
  Location? _location;
Address copyWith({  String? addressLine,
  int? pincode,
  int? cityId,
  Location? location,
}) => Address(  addressLine: addressLine ?? _addressLine,
  pincode: pincode ?? _pincode,
  cityId: cityId ?? _cityId,
  location: location ?? _location,
);
  String? get addressLine => _addressLine;
  int? get pincode => _pincode;
  int? get cityId => _cityId;
  Location? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_line'] = _addressLine;
    map['pincode'] = _pincode;
    map['city_id'] = _cityId;
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    return map;
  }

}

/// latitude : 23.0609355
/// longitude : 72.4483075

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