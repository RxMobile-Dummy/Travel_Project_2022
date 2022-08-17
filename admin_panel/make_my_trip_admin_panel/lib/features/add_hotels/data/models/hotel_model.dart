class Hotel {
    Address? address;
    String deluxebadsize;
    String deluxedescription;
    List<String>? deluxefeatures;
    int deluxemaxcapacity;
    int deluxeprice;
    String deluxesize;
    String description;
    List<String>? features;
    String hotel_name;
    int no_of_room;
    int noodsuperdeluxe;
    int noofdeluxe;
    int noofsemideluxe;
    int phone_number;
    int price;
    int rating;
    String semideluxebadsize;
    String semideluxedescription;
    List<String>? semideluxefeatures;
    int semideluxemaxcapacity;
    int semideluxeprice;
    String semideluxesize;
    String superdeluxebadsize;
    String superdeluxedescription;
    List<String>? superdeluxefeatures;
    int superdeluxemaxcapacity;
    int superdeluxeprice;
    String superdeluxesize;

    Hotel({required this.address,required this.deluxebadsize,required this.deluxedescription,required this.deluxefeatures,required this.deluxemaxcapacity,required this.deluxeprice,required this.deluxesize,required this.description,required this.features,required this.hotel_name, required this.no_of_room,required this.noodsuperdeluxe,required this.noofdeluxe,required this.noofsemideluxe,required this.phone_number,required this.price,required this.rating,required this.semideluxebadsize,required this.semideluxedescription,required this.semideluxefeatures,required this.semideluxemaxcapacity,required this.semideluxeprice,required this.semideluxesize,required this.superdeluxebadsize,required this.superdeluxedescription,required this.superdeluxefeatures,required this.superdeluxemaxcapacity,required this.superdeluxeprice,required this.superdeluxesize});

    factory Hotel.fromJson(Map<String, dynamic> json) {
        return Hotel(
            address: json['address'] != null ? Address.fromJson(json['address']) : null,
            deluxebadsize: json['deluxebadsize'],
            deluxedescription: json['deluxedescription'],
            deluxefeatures: json['deluxefeatures'] != null ? new List<String>.from(json['deluxefeatures']) : null,
            deluxemaxcapacity: json['deluxemaxcapacity'],
            deluxeprice: json['deluxeprice'],
            deluxesize: json['deluxesize'],
            description: json['description'],
            features: json['features'] != null ? new List<String>.from(json['features']) : null,
            hotel_name: json['hotel_name'],
            no_of_room: json['no_of_room'],
            noodsuperdeluxe: json['noodsuperdeluxe'],
            noofdeluxe: json['noofdeluxe'],
            noofsemideluxe: json['noofsemideluxe'],
            phone_number: json['phone_number'],
            price: json['price'],
            rating: json['rating'],
            semideluxebadsize: json['semideluxebadsize'],
            semideluxedescription: json['semideluxedescription'],
            semideluxefeatures: json['semideluxefeatures'] != null ? new List<String>.from(json['semideluxefeatures']) : null,
            semideluxemaxcapacity: json['semideluxemaxcapacity'],
            semideluxeprice: json['semideluxeprice'],
            semideluxesize: json['semideluxesize'],
            superdeluxebadsize: json['superdeluxebadsize'],
            superdeluxedescription: json['superdeluxedescription'],
            superdeluxefeatures: json['superdeluxefeatures'] != null ? new List<String>.from(json['superdeluxefeatures']) : null,
            superdeluxemaxcapacity: json['superdeluxemaxcapacity'],
            superdeluxeprice: json['superdeluxeprice'],
            superdeluxesize: json['superdeluxesize'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['deluxebadsize'] = this.deluxebadsize;
        data['deluxedescription'] = this.deluxedescription;
        data['deluxemaxcapacity'] = this.deluxemaxcapacity;
        data['deluxeprice'] = this.deluxeprice;
        data['deluxesize'] = this.deluxesize;
        data['description'] = this.description;
        data['hotel_name'] = this.hotel_name;
        data['no_of_room'] = this.no_of_room;
        data['noodsuperdeluxe'] = this.noodsuperdeluxe;
        data['noofdeluxe'] = this.noofdeluxe;
        data['noofsemideluxe'] = this.noofsemideluxe;
        data['phone_number'] = this.phone_number;
        data['price'] = this.price;
        data['rating'] = this.rating;
        data['semideluxebadsize'] = this.semideluxebadsize;
        data['semideluxedescription'] = this.semideluxedescription;
        data['semideluxemaxcapacity'] = this.semideluxemaxcapacity;
        data['semideluxeprice'] = this.semideluxeprice;
        data['semideluxesize'] = this.semideluxesize;
        data['superdeluxebadsize'] = this.superdeluxebadsize;
        data['superdeluxedescription'] = this.superdeluxedescription;
        data['superdeluxemaxcapacity'] = this.superdeluxemaxcapacity;
        data['superdeluxeprice'] = this.superdeluxeprice;
        data['superdeluxesize'] = this.superdeluxesize;
        if (this.address != null) {
            data['address'] = this.address?.toJson();
        }
        if (this.deluxefeatures != null) {
            data['deluxefeatures'] = this.deluxefeatures;
        }
        if (this.features != null) {
            data['features'] = this.features;
        }
        if (this.semideluxefeatures != null) {
            data['semideluxefeatures'] = this.semideluxefeatures;
        }
        if (this.superdeluxefeatures != null) {
            data['superdeluxefeatures'] = this.superdeluxefeatures;
        }
        return data;
    }
}

class Address {
    String address_line;
    int city_id;
    Location? location;
    int pincode;
    
    Address({required this.address_line,required this.city_id,required this.location,required this.pincode});

    factory Address.fromJson(Map<String, dynamic> json) {
        return Address(
            address_line: json['address_line'],
            city_id: json['city_id'],
            location: json['location'] != null ? Location.fromJson(json['location']) : null,
            pincode: json['pincode'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address_line'] = this.address_line;
        data['city_id'] = this.city_id;
        data['pincode'] = this.pincode;
        if (this.location != null) {
            data['location'] = this.location!.toJson();
        }
        return data;
    }
}

class Location {
    double latitude;
    double longitude;

    Location({required this.latitude, required this.longitude});

    factory Location.fromJson(Map<String, dynamic> json) {
        return Location(
            latitude: json['latitude'],
            longitude: json['longitude'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['latitude'] = this.latitude;
        data['longitude'] = this.longitude;
        return data;
    }
}