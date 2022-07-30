class RoomCategoryModel {
  String? hotelId;
  String? hotelName;
  List<RoomType>? deluxe;
  List<RoomType>? semiDeluxe;
  List<RoomType>? superDeluxe;

  RoomCategoryModel(
      {this.hotelId,
        this.hotelName,
        this.deluxe,
        this.semiDeluxe,
        this.superDeluxe});

  RoomCategoryModel.fromJson(Map<String, dynamic> json) {
    hotelId = json['hotel_id'];
    hotelName = json['hotel_name'];
    if (json['deluxe'] != null) {
      deluxe = <RoomType>[];
      json['deluxe'].forEach((v) {
        deluxe!.add(RoomType.fromJson(v));
      });
    }
    if (json['semi-deluxe'] != null) {
      semiDeluxe = <RoomType>[];
      json['semi-deluxe'].forEach((v) {
        semiDeluxe!.add(RoomType.fromJson(v));
      });
    }
    if (json['super-deluxe'] != null) {
      superDeluxe = <RoomType>[];
      json['super-deluxe'].forEach((v) {
        superDeluxe!.add(RoomType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hotel_id'] = hotelId;
    data['hotel_name'] = hotelName;
    if (deluxe != null) {
      data['deluxe'] = deluxe!.map((v) => v.toJson()).toList();
    }
    if (semiDeluxe != null) {
      data['semi-deluxe'] = semiDeluxe!.map((v) => v.toJson()).toList();
    }
    if (superDeluxe != null) {
      data['super-deluxe'] = superDeluxe!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoomType {
  int? roomId;
  String? roomType;
  String? roomSize;
  String? bedSize;
  int? maxCapacity;
  int? price;
  List<String>? features;
  String? description;
  List<Images>? image;

  RoomType(
      {this.roomId,
        this.roomType,
        this.roomSize,
        this.bedSize,
        this.maxCapacity,
        this.price,
        this.features,
        this.description,
        this.image});

  RoomType.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    roomType = json['room_type'];
    roomSize = json['room_size'];
    bedSize = json['bed_size'];
    maxCapacity = json['max_capacity'];
    price = json['price'];
    features = json['features'].cast<String>();
    description = json['description'];
    if (json['image'] != null) {
      image = <Images>[];
      json['image'].forEach((v) {
        image!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['room_id'] = roomId;
    data['room_type'] = roomType;
    data['room_size'] = roomSize;
    data['bed_size'] = bedSize;
    data['max_capacity'] = maxCapacity;
    data['price'] = price;
    data['features'] = features;
    data['description'] = description;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? iId;
  String? imageUrl;
  int? hotelId;
  int? roomId;
  Null? tourId;
  Null? userId;

  Images(
      {this.iId,
        this.imageUrl,
        this.hotelId,
        this.roomId,
        this.tourId,
        this.userId});

  Images.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    imageUrl = json['image_url'];
    hotelId = json['hotel_id'];
    roomId = json['room_id'];
    tourId = json['tour_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = iId;
    data['image_url'] = imageUrl;
    data['hotel_id'] = hotelId;
    data['room_id'] = roomId;
    data['tour_id'] = tourId;
    data['user_id'] = userId;
    return data;
  }
}