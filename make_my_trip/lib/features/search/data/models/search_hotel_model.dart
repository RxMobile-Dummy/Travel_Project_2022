import 'dart:convert';

SearchHotelModel searchHotelModelFromJson(String str) =>
    SearchHotelModel.fromJson(json.decode(str));

String searchHotelModelToJson(SearchHotelModel data) =>
    json.encode(data.toJson());

class SearchHotelModel {
  SearchHotelModel({
    int? id,
    String? name,
    String? type,
  }) {
    _id = id;
    _name = name;
    _type = type;
  }

  SearchHotelModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _type = json['type'];
  }

  int? _id;
  String? _name;
  String? _type;

  int? get id => _id;

  String? get name => _name;

  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['type'] = _type;
    return map;
  }
}
