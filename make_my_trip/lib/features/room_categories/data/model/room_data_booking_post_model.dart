import 'dart:convert';
/// hotel_id : 2
/// room_id : [202,201,203]
/// checkin_date : "2022-02-20"
/// checkout_date : "2022-02-20"
/// price : {"number_of_nights":2,"total_price":37000}

RoomDataPostModel roomDataPostModelFromJson(String str) => RoomDataPostModel.fromJson(json.decode(str));
String roomDataPostModelToJson(RoomDataPostModel data) => json.encode(data.toJson());
class RoomDataPostModel {
  RoomDataPostModel({
      this.hotelId, 
      this.roomId, 
      this.checkinDate, 
      this.checkoutDate, 
      this.price,});

  RoomDataPostModel.fromJson(dynamic json) {
    hotelId = json['hotel_id'];
    roomId = json['room_id'] != null ? json['room_id'].cast<int>() : [];
    checkinDate = json['checkin_date'];
    checkoutDate = json['checkout_date'];
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
  }
  int? hotelId;
  List<int>? roomId;
  String? checkinDate;
  String? checkoutDate;
  Price? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hotel_id'] = hotelId;
    map['room_id'] = roomId;
    map['checkin_date'] = checkinDate;
    map['checkout_date'] = checkoutDate;
    if (price != null) {
      map['price'] = price?.toJson();
    }
    return map;
  }

}

/// number_of_nights : 2
/// total_price : 37000

Price priceFromJson(String str) => Price.fromJson(json.decode(str));
String priceToJson(Price data) => json.encode(data.toJson());
class Price {
  Price({
      this.numberOfNights, 
      this.totalPrice,});

  Price.fromJson(dynamic json) {
    numberOfNights = json['number_of_nights'];
    totalPrice = json['total_price'];
  }
  int? numberOfNights;
  int? totalPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number_of_nights'] = numberOfNights;
    map['total_price'] = totalPrice;
    return map;
  }

}