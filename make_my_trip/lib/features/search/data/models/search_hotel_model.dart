import 'dart:convert';

SearchHotelModel searchHotelModelFromJson(String str) =>
    SearchHotelModel.fromJson(json.decode(str));

String searchHotelModelToJson(SearchHotelModel data) =>
    json.encode(data.toJson());

class SearchHotelModel {
  SearchHotelModel({
    String? placeId,
    String? description,
    String? reference,
  }) {
    _placeId = placeId;
    _description = description;
    _reference = reference;
  }

  SearchHotelModel.fromJson(dynamic json) {
    _placeId = json['place_id'];
    _description = json['description'];
    _reference = json['reference'];
  }

  String? _placeId;
  String? _description;
  String? _reference;

  String? get placeId => _placeId;

  String? get description => _description;

  String? get reference => _reference;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['place_id'] = _placeId;
    map['description'] = _description;
    map['reference'] = _reference;
    return map;
  }
}
