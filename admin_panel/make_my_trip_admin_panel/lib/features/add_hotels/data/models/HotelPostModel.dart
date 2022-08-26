import 'dart:convert';
/// hotel_name : "Hotel Syal Inn Amritsar"
/// address : {"address_line":"Cooper Road, Bhandari Pull Near Giani Tea Stall, opposite Inderpuri Foods, Crystal Chowk, Amritsar, Punjab, India 143001","city_id":146,"pincode":143001,"location":{"latitude":23.052107,"longitude":72.57090050000001}}
/// rating : 5
/// price : 11700
/// phone_number : 457845124545
/// no_of_room : 3
/// description : "The restaurant is named Patang, literally a fighter kite in Gujarati language. It was designed by an architect Hasmukh Patel.[5][6][4] The restaurant and the adjoining Chinubhai Centre, a commercial complex, were built in 1980–1984 at a cost of approximately ₹1.25 crore"
/// features : ["Parking","Healthy Breakfast","Transportation","Laundry","Entertainment"]
/// noofdeluxe : 3
/// noodsuperdeluxe : 1
/// noofsemideluxe : 2
/// deluxesize : "150 square feet"
/// deluxebadsize : "Twin bed"
/// deluxemaxcapacity : 2
/// deluxeprice : 5000
/// deluxefeatures : [" Free internet","Coffee / Tea maker","Soundproof walls","Smart TV with satellite","Individually air conditioning"]
/// deluxedescription : "Deluxe rooms, are modern decorated, can accommodate up to 2 persons, totally soundproofed and equipped with high tech comforts such as high speed internet access, USB ports , smart TV, room cleaning touch system and private hydromassage bathtub"
/// semideluxesize : "150 square feet"
/// semideluxebadsize : "Twin bed"
/// semideluxemaxcapacity : 2
/// semideluxeprice : 5000
/// semideluxefeatures : [" Free internet","Coffee / Tea maker","Soundproof walls","Smart TV with satellite","Individually air conditioning"]
/// semideluxedescription : "Semi Deluxe rooms, are modern decorated, can accommodate up to 2 persons, totally soundproofed and equipped with high tech comforts such as high speed internet access, USB ports , smart TV, room cleaning touch system and private hydromassage bathtub"
/// superdeluxesize : "150 square feet"
/// superdeluxebadsize : "Twin bed"
/// superdeluxemaxcapacity : 2
/// superdeluxeprice : 5000
/// superdeluxefeatures : [" Free internet","Coffee / Tea maker","Soundproof walls","Smart TV with satellite","Individually air conditioning"]
/// superdeluxedescription : "Super Deluxe rooms, are modern decorated, can accommodate up to 2 persons, totally soundproofed and equipped with high tech comforts such as high speed internet access, USB ports , smart TV, room cleaning touch system and private hydromassage bathtub"
/// hotelimages : ["url1"]
/// deluxeimages : ["url3"]
/// semideluxeimages : ["url5"]
/// superdeluxeimages : ["url8"]

HotelPostModel hotelPostModelFromJson(String str) => HotelPostModel.fromJson(json.decode(str));
String hotelPostModelToJson(HotelPostModel data) => json.encode(data.toJson());
class HotelPostModel {
  HotelPostModel({
      this.hotelName, 
      this.address, 
      this.rating, 
      this.price, 
      this.phoneNumber, 
      this.noOfRoom, 
      this.description, 
      this.features, 
      this.noofdeluxe, 
      this.noodsuperdeluxe, 
      this.noofsemideluxe, 
      this.deluxesize, 
      this.deluxebadsize, 
      this.deluxemaxcapacity, 
      this.deluxeprice, 
      this.deluxefeatures, 
      this.deluxedescription, 
      this.semideluxesize, 
      this.semideluxebadsize, 
      this.semideluxemaxcapacity, 
      this.semideluxeprice, 
      this.semideluxefeatures, 
      this.semideluxedescription, 
      this.superdeluxesize, 
      this.superdeluxebadsize, 
      this.superdeluxemaxcapacity, 
      this.superdeluxeprice, 
      this.superdeluxefeatures, 
      this.superdeluxedescription, 
      this.hotelimages, 
      this.deluxeimages, 
      this.semideluxeimages, 
      this.superdeluxeimages,});

  HotelPostModel.fromJson(dynamic json) {
    hotelName = json['hotel_name'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    rating = json['rating'];
    price = json['price'];
    phoneNumber = json['phone_number'];
    noOfRoom = json['no_of_room'];
    description = json['description'];
    features = json['features'] != null ? json['features'].cast<String>() : [];
    noofdeluxe = json['noofdeluxe'];
    noodsuperdeluxe = json['noodsuperdeluxe'];
    noofsemideluxe = json['noofsemideluxe'];
    deluxesize = json['deluxesize'];
    deluxebadsize = json['deluxebadsize'];
    deluxemaxcapacity = json['deluxemaxcapacity'];
    deluxeprice = json['deluxeprice'];
    deluxefeatures = json['deluxefeatures'] != null ? json['deluxefeatures'].cast<String>() : [];
    deluxedescription = json['deluxedescription'];
    semideluxesize = json['semideluxesize'];
    semideluxebadsize = json['semideluxebadsize'];
    semideluxemaxcapacity = json['semideluxemaxcapacity'];
    semideluxeprice = json['semideluxeprice'];
    semideluxefeatures = json['semideluxefeatures'] != null ? json['semideluxefeatures'].cast<String>() : [];
    semideluxedescription = json['semideluxedescription'];
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
  String? hotelName;
  Address? address;
  num? rating;
  num? price;
  num? phoneNumber;
  num? noOfRoom;
  String? description;
  List<String>? features;
  num? noofdeluxe;
  num? noodsuperdeluxe;
  num? noofsemideluxe;
  String? deluxesize;
  String? deluxebadsize;
  num? deluxemaxcapacity;
  num? deluxeprice;
  List<String>? deluxefeatures;
  String? deluxedescription;
  String? semideluxesize;
  String? semideluxebadsize;
  num? semideluxemaxcapacity;
  num? semideluxeprice;
  List<String>? semideluxefeatures;
  String? semideluxedescription;
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
    map['noodsuperdeluxe'] = noodsuperdeluxe;
    map['noofsemideluxe'] = noofsemideluxe;
    map['deluxesize'] = deluxesize;
    map['deluxebadsize'] = deluxebadsize;
    map['deluxemaxcapacity'] = deluxemaxcapacity;
    map['deluxeprice'] = deluxeprice;
    map['deluxefeatures'] = deluxefeatures;
    map['deluxedescription'] = deluxedescription;
    map['semideluxesize'] = semideluxesize;
    map['semideluxebadsize'] = semideluxebadsize;
    map['semideluxemaxcapacity'] = semideluxemaxcapacity;
    map['semideluxeprice'] = semideluxeprice;
    map['semideluxefeatures'] = semideluxefeatures;
    map['semideluxedescription'] = semideluxedescription;
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

/// address_line : "Cooper Road, Bhandari Pull Near Giani Tea Stall, opposite Inderpuri Foods, Crystal Chowk, Amritsar, Punjab, India 143001"
/// city_id : 146
/// pincode : 143001
/// location : {"latitude":23.052107,"longitude":72.57090050000001}

Address addressFromJson(String str) => Address.fromJson(json.decode(str));
String addressToJson(Address data) => json.encode(data.toJson());
class Address {
  Address({
      this.addressLine, 
      this.cityId, 
      this.pincode, 
      this.location,});

  Address.fromJson(dynamic json) {
    addressLine = json['address_line'];
    cityId = json['city_id'];
    pincode = json['pincode'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
  }
  String? addressLine;
  num? cityId;
  num? pincode;
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

/// latitude : 23.052107
/// longitude : 72.57090050000001

Location locationFromJson(String str) => Location.fromJson(json.decode(str));
String locationToJson(Location data) => json.encode(data.toJson());
class Location {
  Location({
      this.latitude, 
      this.longitude,});

  Location.fromJson(dynamic json) {
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