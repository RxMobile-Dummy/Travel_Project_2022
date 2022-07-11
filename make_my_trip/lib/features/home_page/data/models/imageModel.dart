/// _id : 18
/// image_url : "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F100.jpg?alt=media&token=95abd6b8-d27e-4f3f-93bb-984175b41beb"
/// hotel_id : 1
/// room_id : null
/// tour_id : null
/// user_id : null

class ImageModel {
  ImageModel({
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

  ImageModel.fromJson(dynamic json) {
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
ImageModel copyWith({  int? id,
  String? imageUrl,
  int? hotelId,
  dynamic roomId,
  dynamic tourId,
  dynamic userId,
}) => ImageModel(  id: id ?? _id,
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