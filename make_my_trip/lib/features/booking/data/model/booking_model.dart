import 'dart:convert';

/// hotelid : 1
/// hotelName : "Hotel Khyber Palace"
/// address : "Sanand Cir, Sarkhej, Ahmedabad, Gujarat, India 382210"
/// rating : 1.0
/// checkInDate : "2020-08-08T00:00:00.000Z"
/// checkOutDate : "2020-08-10T00:00:00.000Z"
/// roomId : [105,109]
/// roomPrice : 13500
/// noOfDays : 2
/// subTotal : 27000
/// gstPercentage : 18
/// discountPercentage : 5
/// gst : 4860
/// offer : 1593
/// total : 30267

BookingModel bookingModelFromJson(String str) =>
    BookingModel.fromJson(json.decode(str));
String bookingModelToJson(BookingModel data) => json.encode(data.toJson());

class BookingModel {
  BookingModel({
    this.hotelid,
    this.hotelName,
    this.address,
    this.rating,
    this.checkInDate,
    this.checkOutDate,
    this.roomId,
    this.roomPrice,
    this.noOfDays,
    this.subTotal,
    this.gstPercentage,
    this.discountPercentage,
    this.gst,
    this.offer,
    this.total,
  });

  BookingModel.fromJson(dynamic json) {
    hotelid = json['hotelid'];
    hotelName = json['hotelName'];
    address = json['address'];
    rating = json['rating'];
    checkInDate = json['checkInDate'];
    checkOutDate = json['checkOutDate'];
    roomId = json['roomId'] != null ? json['roomId'].cast<int>() : [];
    roomPrice = json['roomPrice'];
    noOfDays = json['noOfDays'];
    subTotal = json['subTotal'];
    gstPercentage = json['gstPercentage'];
    discountPercentage = json['discountPercentage'];
    gst = json['gst'];
    offer = json['offer'];
    total = json['total'];
  }
  int? hotelid;
  String? hotelName;
  String? address;
  double? rating;
  String? checkInDate;
  String? checkOutDate;
  List<int>? roomId;
  int? roomPrice;
  int? noOfDays;
  int? subTotal;
  int? gstPercentage;
  int? discountPercentage;
  int? gst;
  int? offer;
  int? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hotelid'] = hotelid;
    map['hotelName'] = hotelName;
    map['address'] = address;
    map['rating'] = rating;
    map['checkInDate'] = checkInDate;
    map['checkOutDate'] = checkOutDate;
    map['roomId'] = roomId;
    map['roomPrice'] = roomPrice;
    map['noOfDays'] = noOfDays;
    map['subTotal'] = subTotal;
    map['gstPercentage'] = gstPercentage;
    map['discountPercentage'] = discountPercentage;
    map['gst'] = gst;
    map['offer'] = offer;
    map['total'] = total;
    return map;
  }
}
