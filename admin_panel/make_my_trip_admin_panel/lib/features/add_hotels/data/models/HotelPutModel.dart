import 'dart:convert';
/// _id : 1
/// hotel_name : "Hotel Khyber Palace"
/// address : {"address_line":"Sanand Cir, Sarkhej, Ahmedabad, Gujarat, India 382210","city_id":69,"pincode":382210,"location":{"latitude":23.0609355,"longitude":23.0609355}}
/// rating : 4.4
/// price : 2000
/// phone_number : 9484607521
/// no_of_room : 3
/// description : "The restaurant is named Patang, literally a fighter kite in Gujarati language. It was designed by an architect Hasmukh Patel.[5][6][4] The restaurant and the adjoining Chinubhai Centre, a commercial complex, were built in 1980–1984 at a cost of approximately ₹1.25 crore"
/// features : ["Laundry","Transportation","Entertainment","Parking","Healthy Breakfast"]
/// noofdeluxe : 3
/// deluxesize : "150 square feet"
/// deluxebadsize : "Twin bed"
/// deluxemaxcapacity : 2
/// deluxeprice : 5000
/// deluxefeatures : ["Free internet","Coffee / Tea maker","Soundproof walls","Smart TV with satellite","Individually air conditioning"]
/// deluxedescription : "Deluxe rooms, are modern decorated, can accommodate up to 2 persons, totally soundproofed and equipped with high tech comforts such as high speed internet access, USB ports , smart TV, room cleaning touch system and private hydromassage bathtub"
/// noofsemideluxe : 3
/// semideluxesize : "100 square feet"
/// semideluxebadsize : "Twin bed"
/// semideluxemaxcapacity : 2
/// semideluxeprice : 5500
/// semideluxefeatures : ["Free internet","Coffee / Tea maker","Mini-Fridge","Smart TV with satellite","Individually air conditioning"]
/// semideluxedescription : "Semi-Deluxe rooms, are modern decorated, can accommodate up to 2 persons, totally soundproofed and equipped with high tech comforts such as high speed internet access, USB ports , smart TV, room cleaning touch system and private hydromassage bathtub"
/// noodsuperdeluxe : 3
/// superdeluxesize : "200 square feet"
/// superdeluxebadsize : "Twin bed"
/// superdeluxemaxcapacity : 2
/// superdeluxeprice : 8000
/// superdeluxefeatures : ["Free internet","Pet-Friendly Rooms","Coffee / Tea maker","Mini-Fridge","Smart TV with satellite","Individually air conditioning"]
/// superdeluxedescription : "Super-Deluxe rooms, are modern decorated, can accommodate up to 2 persons, totally soundproofed and equipped with high tech comforts such as high speed internet access, USB ports , smart TV, room cleaning touch system and private hydromassage bathtub"

HotelPutModel hotelPutModelFromJson(String str) => HotelPutModel.fromJson(json.decode(str));
String hotelPutModelToJson(HotelPutModel data) => json.encode(data.toJson());
class HotelPutModel {
  HotelPutModel({
      this.id, 
      this.hotelName, 
      this.address,
      this.rating, 
      this.price, 
      this.phoneNumber, 
      this.noOfRoom, 
      this.description, 
      this.features, 
      this.noofdeluxe, 
      this.deluxesize, 
      this.deluxebadsize, 
      this.deluxemaxcapacity, 
      this.deluxeprice, 
      this.deluxefeatures, 
      this.deluxedescription, 
      this.noofsemideluxe, 
      this.semideluxesize, 
      this.semideluxebadsize, 
      this.semideluxemaxcapacity, 
      this.semideluxeprice, 
      this.semideluxefeatures, 
      this.semideluxedescription, 
      this.noodsuperdeluxe, 
      this.superdeluxesize, 
      this.superdeluxebadsize, 
      this.superdeluxemaxcapacity, 
      this.superdeluxeprice, 
      this.superdeluxefeatures, 
      this.superdeluxedescription,
      this.hotelimages,
      this.deluxeimages,
      this.semideluxeimages,
      this.superdeluxeimages,
  });

  HotelPutModel.fromJson(dynamic json) {
    id = json['_id'];
    hotelName = json['hotel_name'];
    address = json['address'] != null ? Addresss.fromJson(json['address']) : null;
    rating = json['rating'];
    price = json['price'];
    phoneNumber = json['phone_number'];
    noOfRoom = json['no_of_room'];
    description = json['description'];
    features = json['features'] != null ? json['features'].cast<String>() : [];
    noofdeluxe = json['noofdeluxe'];
    deluxesize = json['deluxesize'];
    deluxebadsize = json['deluxebadsize'];
    deluxemaxcapacity = json['deluxemaxcapacity'];
    deluxeprice = json['deluxeprice'];
    deluxefeatures = json['deluxefeatures'] != null ? json['deluxefeatures'].cast<String>() : [];
    deluxedescription = json['deluxedescription'];
    noofsemideluxe = json['noofsemideluxe'];
    semideluxesize = json['semideluxesize'];
    semideluxebadsize = json['semideluxebadsize'];
    semideluxemaxcapacity = json['semideluxemaxcapacity'];
    semideluxeprice = json['semideluxeprice'];
    semideluxefeatures = json['semideluxefeatures'] != null ? json['semideluxefeatures'].cast<String>() : [];
    semideluxedescription = json['semideluxedescription'];
    noodsuperdeluxe = json['noodsuperdeluxe'];
    superdeluxesize = json['superdeluxesize'];
    superdeluxebadsize = json['superdeluxebadsize'];
    superdeluxemaxcapacity = json['superdeluxemaxcapacity'];
    superdeluxeprice = json['superdeluxeprice'];
    superdeluxefeatures = json['superdeluxefeatures'] != null ? json['superdeluxefeatures'].cast<String>() : [];
    superdeluxedescription = json['superdeluxedescription'];
    hotelimages = json['hotelimages'] != null ? json['hotelimages'].cast<String>() : [];
    deluxeimages = json['deluxeimages'] != null ? json['deluxeimages'].cast<String>() : [];
    semideluxeimages = json['semideluxeimages'] != null ? json['semideluxeimages'].cast<String>() : [];
    superdeluxeimages = json['superdeluxeimages'] != null ? json['superdeluxeimages'].cast<String>() : [];
  }
  num? id;
  String? hotelName;
  Addresss? address;
  double? rating;
  num? price;
  num? phoneNumber;
  num? noOfRoom;
  String? description;
  List<String>? features;
  num? noofdeluxe;
  String? deluxesize;
  String? deluxebadsize;
  num? deluxemaxcapacity;
  num? deluxeprice;
  List<String>? deluxefeatures;
  String? deluxedescription;
  num? noofsemideluxe;
  String? semideluxesize;
  String? semideluxebadsize;
  num? semideluxemaxcapacity;
  num? semideluxeprice;
  List<String>? semideluxefeatures;
  String? semideluxedescription;
  num? noodsuperdeluxe;
  String? superdeluxesize;
  String? superdeluxebadsize;
  num? superdeluxemaxcapacity;
  num? superdeluxeprice;
  List<String>? superdeluxefeatures;
  String? superdeluxedescription;
  List<String>? hotelimages;
  List<String>? deluxeimages;
  List<String>? semideluxeimages;
  List<String>? superdeluxeimages;

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
    map['no_of_room'] = noOfRoom;
    map['description'] = description;
    map['features'] = features;
    map['noofdeluxe'] = noofdeluxe;
    map['deluxesize'] = deluxesize;
    map['deluxebadsize'] = deluxebadsize;
    map['deluxemaxcapacity'] = deluxemaxcapacity;
    map['deluxeprice'] = deluxeprice;
    map['deluxefeatures'] = deluxefeatures;
    map['deluxedescription'] = deluxedescription;
    map['noofsemideluxe'] = noofsemideluxe;
    map['semideluxesize'] = semideluxesize;
    map['semideluxebadsize'] = semideluxebadsize;
    map['semideluxemaxcapacity'] = semideluxemaxcapacity;
    map['semideluxeprice'] = semideluxeprice;
    map['semideluxefeatures'] = semideluxefeatures;
    map['semideluxedescription'] = semideluxedescription;
    map['noodsuperdeluxe'] = noodsuperdeluxe;
    map['superdeluxesize'] = superdeluxesize;
    map['superdeluxebadsize'] = superdeluxebadsize;
    map['superdeluxemaxcapacity'] = superdeluxemaxcapacity;
    map['superdeluxeprice'] = superdeluxeprice;
    map['superdeluxefeatures'] = superdeluxefeatures;
    map['superdeluxedescription'] = superdeluxedescription;
    map['hotelimages'] = hotelimages;
    map['deluxeimages'] = deluxeimages;
    map['semideluxeimages'] = semideluxeimages;
    map['superdeluxeimages'] = superdeluxeimages;
    return map;
  }

}

/// address_line : "Sanand Cir, Sarkhej, Ahmedabad, Gujarat, India 382210"
/// city_id : 69
/// pincode : 382210
/// location : {"latitude":23.0609355,"longitude":23.0609355}

Addresss addressFromJson(String str) => Addresss.fromJson(json.decode(str));
String addressToJson(Addresss data) => json.encode(data.toJson());
class Addresss {
  Addresss({
      this.addressLine, 
      this.cityId, 
      this.pincode, 
      this.location,});

  Addresss.fromJson(dynamic json) {
    addressLine = json['address_line'];
    cityId = json['city_id'];
    pincode = json['pincode'];
    location = json['location'] != null ? Locationn.fromJson(json['location']) : null;
  }
  String? addressLine;
  num? cityId;
  num? pincode;
  Locationn? location;

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

/// latitude : 23.0609355
/// longitude : 23.0609355

Locationn locationFromJson(String str) => Locationn.fromJson(json.decode(str));
String locationToJson(Locationn data) => json.encode(data.toJson());
class Locationn {
  Locationn({
      this.latitude, 
      this.longitude,});

  Locationn.fromJson(dynamic json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
  num? latitude;
  num? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }

}