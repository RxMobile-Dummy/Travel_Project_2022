/// _id : 1
/// tour_name : "Minute To Visit."
/// rating : 5
/// price : 5000
/// details : [{"_id":41,"image_url":"https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F12.jpg?alt=media&token=817b5b0a-4acf-4030-8842-027578f5c105","hotel_id":null,"room_id":null,"tour_id":1,"user_id":null}]

class ToursModel {
  ToursModel({
    int? id,
    String? tourName,
    int? rating,
    int? price,
    List<Details>? details,
  }) {
    _id = id;
    _tourName = tourName;
    _rating = rating;
    _price = price;
    _details = details;
  }

  ToursModel.fromJson(dynamic json) {
    _id = json['_id'];
    _tourName = json['tour_name'];
    _rating = json['rating'];
    _price = json['price'];
    if (json['details'] != null) {
      _details = [];
      json['details'].forEach((v) {
        _details?.add(Details.fromJson(v));
      });
    }
  }
  int? _id;
  String? _tourName;
  int? _rating;
  int? _price;
  List<Details>? _details;
  ToursModel copyWith({
    int? id,
    String? tourName,
    int? rating,
    int? price,
    List<Details>? details,
  }) =>
      ToursModel(
        id: id ?? _id,
        tourName: tourName ?? _tourName,
        rating: rating ?? _rating,
        price: price ?? _price,
        details: details ?? _details,
      );
  int? get id => _id;
  String? get tourName => _tourName;
  int? get rating => _rating;
  int? get price => _price;
  List<Details>? get details => _details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['tour_name'] = _tourName;
    map['rating'] = _rating;
    map['price'] = _price;
    if (_details != null) {
      map['details'] = _details?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : 41
/// image_url : "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F12.jpg?alt=media&token=817b5b0a-4acf-4030-8842-027578f5c105"
/// hotel_id : null
/// room_id : null
/// tour_id : 1
/// user_id : null

class Details {
  Details({
    int? id,
    String? imageUrl,
    dynamic hotelId,
    dynamic roomId,
    int? tourId,
    dynamic userId,
  }) {
    _id = id;
    _imageUrl = imageUrl;
    _hotelId = hotelId;
    _roomId = roomId;
    _tourId = tourId;
    _userId = userId;
  }

  Details.fromJson(dynamic json) {
    _id = json['_id'];
    _imageUrl = json['image_url'];
    _hotelId = json['hotel_id'];
    _roomId = json['room_id'];
    _tourId = json['tour_id'];
    _userId = json['user_id'];
  }
  int? _id;
  String? _imageUrl;
  dynamic _hotelId;
  dynamic _roomId;
  int? _tourId;
  dynamic _userId;
  Details copyWith({
    int? id,
    String? imageUrl,
    dynamic hotelId,
    dynamic roomId,
    int? tourId,
    dynamic userId,
  }) =>
      Details(
        id: id ?? _id,
        imageUrl: imageUrl ?? _imageUrl,
        hotelId: hotelId ?? _hotelId,
        roomId: roomId ?? _roomId,
        tourId: tourId ?? _tourId,
        userId: userId ?? _userId,
      );
  int? get id => _id;
  String? get imageUrl => _imageUrl;
  dynamic get hotelId => _hotelId;
  dynamic get roomId => _roomId;
  int? get tourId => _tourId;
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
