import 'dart:convert';

/// _id : 14
/// user_id : "SyNy85NLZRhAwZmgUjbFWQYoKbA2"
/// hotel_id : 1
/// no_of_room : 1
/// room_id : [104]
/// checkin_date : "2022-08-01T00:00:00.000Z"
/// checkout_date : "2022-08-06T00:00:00.000Z"
/// price : {"number_of_nights":5,"room_price":25000,"discount":1475,"gst":4500,"total_price":28025}
/// booked_date : "2022-07-30T14:23:34.532Z"
/// coupon_id : null
/// status : "success"
/// userdata : [{"_id":"SyNy85NLZRhAwZmgUjbFWQYoKbA2","user_name":"sky","user_email":"guptakash7383@gmail.com","user_image":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/userImage%2Fscaled_image_picker7437847556433787664.jpg?alt=media&token=284775d4-1bd5-448e-9dd3-11b097d8e765"}]
/// hoteldata : [{"_id":1,"hotel_name":"Hotel Khyber Palace"}]

BookingModerationModel bookingModerationModelFromJson(String str) =>
    BookingModerationModel.fromJson(json.decode(str));

String bookingModerationModelToJson(BookingModerationModel data) =>
    json.encode(data.toJson());

class BookingModerationModel {
  BookingModerationModel({
    num? id,
    String? userId,
    num? hotelId,
    num? noOfRoom,
    List<num>? roomId,
    String? checkinDate,
    String? checkoutDate,
    Price? price,
    String? bookedDate,
    dynamic couponId,
    String? status,
    List<Userdata>? userdata,
    List<Hoteldata>? hoteldata,
  }) {
    _id = id;
    _userId = userId;
    _hotelId = hotelId;
    _noOfRoom = noOfRoom;
    _roomId = roomId;
    _checkinDate = checkinDate;
    _checkoutDate = checkoutDate;
    _price = price;
    _bookedDate = bookedDate;
    _couponId = couponId;
    _status = status;
    _userdata = userdata;
    _hoteldata = hoteldata;
  }

  BookingModerationModel.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['user_id'];
    _hotelId = json['hotel_id'];
    _noOfRoom = json['no_of_room'];
    _roomId = json['room_id'] != null ? json['room_id'].cast<num>() : [];
    _checkinDate = json['checkin_date'];
    _checkoutDate = json['checkout_date'];
    _price = json['price'] != null ? Price.fromJson(json['price']) : null;
    _bookedDate = json['booked_date'];
    _couponId = json['coupon_id'];
    _status = json['status'];
    if (json['userdata'] != null) {
      _userdata = [];
      json['userdata'].forEach((v) {
        _userdata?.add(Userdata.fromJson(v));
      });
    }
    if (json['hoteldata'] != null) {
      _hoteldata = [];
      json['hoteldata'].forEach((v) {
        _hoteldata?.add(Hoteldata.fromJson(v));
      });
    }
  }

  num? _id;
  String? _userId;
  num? _hotelId;
  num? _noOfRoom;
  List<num>? _roomId;
  String? _checkinDate;
  String? _checkoutDate;
  Price? _price;
  String? _bookedDate;
  dynamic _couponId;
  String? _status;
  List<Userdata>? _userdata;
  List<Hoteldata>? _hoteldata;

  num? get id => _id;

  String? get userId => _userId;

  num? get hotelId => _hotelId;

  num? get noOfRoom => _noOfRoom;

  List<num>? get roomId => _roomId;

  String? get checkinDate => _checkinDate;

  String? get checkoutDate => _checkoutDate;

  Price? get price => _price;

  String? get bookedDate => _bookedDate;

  dynamic get couponId => _couponId;

  String? get status => _status;

  List<Userdata>? get userdata => _userdata;

  List<Hoteldata>? get hoteldata => _hoteldata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['user_id'] = _userId;
    map['hotel_id'] = _hotelId;
    map['no_of_room'] = _noOfRoom;
    map['room_id'] = _roomId;
    map['checkin_date'] = _checkinDate;
    map['checkout_date'] = _checkoutDate;
    if (_price != null) {
      map['price'] = _price?.toJson();
    }
    map['booked_date'] = _bookedDate;
    map['coupon_id'] = _couponId;
    map['status'] = _status;
    if (_userdata != null) {
      map['userdata'] = _userdata?.map((v) => v.toJson()).toList();
    }
    if (_hoteldata != null) {
      map['hoteldata'] = _hoteldata?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : 1
/// hotel_name : "Hotel Khyber Palace"

Hoteldata hoteldataFromJson(String str) => Hoteldata.fromJson(json.decode(str));

String hoteldataToJson(Hoteldata data) => json.encode(data.toJson());

class Hoteldata {
  Hoteldata({
    num? id,
    String? hotelName,
  }) {
    _id = id;
    _hotelName = hotelName;
  }

  Hoteldata.fromJson(dynamic json) {
    _id = json['_id'];
    _hotelName = json['hotel_name'];
  }

  num? _id;
  String? _hotelName;

  num? get id => _id;

  String? get hotelName => _hotelName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['hotel_name'] = _hotelName;
    return map;
  }
}

/// _id : "SyNy85NLZRhAwZmgUjbFWQYoKbA2"
/// user_name : "sky"
/// user_email : "guptakash7383@gmail.com"
/// user_image : "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/userImage%2Fscaled_image_picker7437847556433787664.jpg?alt=media&token=284775d4-1bd5-448e-9dd3-11b097d8e765"

Userdata userdataFromJson(String str) => Userdata.fromJson(json.decode(str));

String userdataToJson(Userdata data) => json.encode(data.toJson());

class Userdata {
  Userdata({
    String? id,
    String? userName,
    String? userEmail,
    String? userImage,
  }) {
    _id = id;
    _userName = userName;
    _userEmail = userEmail;
    _userImage = userImage;
  }

  Userdata.fromJson(dynamic json) {
    _id = json['_id'];
    _userName = json['user_name'];
    _userEmail = json['user_email'];
    _userImage = json['user_image'];
  }

  String? _id;
  String? _userName;
  String? _userEmail;
  String? _userImage;

  String? get id => _id;

  String? get userName => _userName;

  String? get userEmail => _userEmail;

  String? get userImage => _userImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['user_name'] = _userName;
    map['user_email'] = _userEmail;
    map['user_image'] = _userImage;
    return map;
  }
}

/// number_of_nights : 5
/// room_price : 25000
/// discount : 1475
/// gst : 4500
/// total_price : 28025

Price priceFromJson(String str) => Price.fromJson(json.decode(str));

String priceToJson(Price data) => json.encode(data.toJson());

class Price {
  Price({
    num? numberOfNights,
    num? roomPrice,
    num? discount,
    num? gst,
    num? totalPrice,
  }) {
    _numberOfNights = numberOfNights;
    _roomPrice = roomPrice;
    _discount = discount;
    _gst = gst;
    _totalPrice = totalPrice;
  }

  Price.fromJson(dynamic json) {
    _numberOfNights = json['number_of_nights'];
    _roomPrice = json['room_price'];
    _discount = json['discount'];
    _gst = json['gst'];
    _totalPrice = json['total_price'];
  }

  num? _numberOfNights;
  num? _roomPrice;
  num? _discount;
  num? _gst;
  num? _totalPrice;

  num? get numberOfNights => _numberOfNights;

  num? get roomPrice => _roomPrice;

  num? get discount => _discount;

  num? get gst => _gst;

  num? get totalPrice => _totalPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number_of_nights'] = _numberOfNights;
    map['room_price'] = _roomPrice;
    map['discount'] = _discount;
    map['gst'] = _gst;
    map['total_price'] = _totalPrice;
    return map;
  }
}
