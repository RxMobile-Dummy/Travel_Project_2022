import 'dart:convert';
/// hotel_id : 1
/// no_of_room : 1
/// room_id : [1,1,1]
/// checkin_date : ""
/// checkout_date : ""
/// price : {"number_of_nights":1,"room_price":1247,"gst":18,"discount":5,"total_price":5000}

RoomDataPostModel roomDataPostModelFromJson(String str) => RoomDataPostModel.fromJson(json.decode(str));
String roomDataPostModelToJson(RoomDataPostModel data) => json.encode(data.toJson());
class RoomDataPostModel {
  RoomDataPostModel({
    this.hotelId,
    this.noOfRoom,
    this.roomId,
    this.checkinDate,
    this.checkoutDate,
    this.price,});

  RoomDataPostModel.fromJson(dynamic json) {
    hotelId = json['hotel_id'];
    noOfRoom = json['no_of_room'];
    roomId = json['room_id'] != null ? json['room_id'].cast<int>() : [];
    checkinDate = json['checkin_date'];
    checkoutDate = json['checkout_date'];
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
  }
  int? hotelId;
  int? noOfRoom;
  List<int>? roomId;
  String? checkinDate;
  String? checkoutDate;
  Price? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hotel_id'] = hotelId;
    map['no_of_room'] = noOfRoom;
    map['room_id'] = roomId;
    map['checkin_date'] = checkinDate;
    map['checkout_date'] = checkoutDate;
    if (price != null) {
      map['price'] = price?.toJson();
    }
    return map;
  }

}

/// number_of_nights : 1
/// room_price : 1247
/// gst : 18
/// discount : 5
/// total_price : 5000

Price priceFromJson(String str) => Price.fromJson(json.decode(str));
String priceToJson(Price data) => json.encode(data.toJson());
class Price {
  Price({
    this.numberOfNights,
    this.roomPrice,
    this.gst,
    this.discount,
    this.totalPrice,});

  Price.fromJson(dynamic json) {
    numberOfNights = json['number_of_nights'];
    roomPrice = json['room_price'];
    gst = json['gst'];
    discount = json['discount'];
    totalPrice = json['total_price'];
  }
  int? numberOfNights;
  int? roomPrice;
  int? gst;
  int? discount;
  int? totalPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number_of_nights'] = numberOfNights;
    map['room_price'] = roomPrice;
    map['gst'] = gst;
    map['discount'] = discount;
    map['total_price'] = totalPrice;
    return map;
  }

}