import 'dart:convert';

/// predictions : [{"description":"Amsterdam, Netherlands","matched_substrings":[{"length":1,"offset":0}],"place_id":"ChIJVXealLU_xkcRja_At0z9AGY","reference":"ChIJVXealLU_xkcRja_At0z9AGY","structured_formatting":[{"main_text":"Amsterdam","main_text_matched_substrings":[{"length":1,"offset":0}],"secondary_text":"Netherlands"}]}]

SearchHotelModel searchHotelModelFromJson(String str) =>
    SearchHotelModel.fromJson(json.decode(str));

String searchHotelModelToJson(SearchHotelModel data) =>
    json.encode(data.toJson());

class SearchHotelModel {
  SearchHotelModel({
    List<Predictions>? predictions,
  }) {
    _predictions = predictions;
  }

  SearchHotelModel.fromJson(dynamic json) {
    if (json['predictions'] != null) {
      _predictions = [];
      json['predictions'].forEach((v) {
        _predictions?.add(Predictions.fromJson(v));
      });
    }
  }

  List<Predictions>? _predictions;

  List<Predictions>? get predictions => _predictions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_predictions != null) {
      map['predictions'] = _predictions?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// description : "Amsterdam, Netherlands"
/// matched_substrings : [{"length":1,"offset":0}]
/// place_id : "ChIJVXealLU_xkcRja_At0z9AGY"
/// reference : "ChIJVXealLU_xkcRja_At0z9AGY"
/// structured_formatting : [{"main_text":"Amsterdam","main_text_matched_substrings":[{"length":1,"offset":0}],"secondary_text":"Netherlands"}]

Predictions predictionsFromJson(String str) =>
    Predictions.fromJson(json.decode(str));

String predictionsToJson(Predictions data) => json.encode(data.toJson());

class Predictions {
  Predictions({
    String? description,
    List<MatchedSubstrings>? matchedSubstrings,
    String? placeId,
    String? reference,
    List<StructuredFormatting>? structuredFormatting,
  }) {
    _description = description;
    _matchedSubstrings = matchedSubstrings;
    _placeId = placeId;
    _reference = reference;
    _structuredFormatting = structuredFormatting;
  }

  Predictions.fromJson(dynamic json) {
    _description = json['description'];
    if (json['matched_substrings'] != null) {
      _matchedSubstrings = [];
      json['matched_substrings'].forEach((v) {
        _matchedSubstrings?.add(MatchedSubstrings.fromJson(v));
      });
    }
    _placeId = json['place_id'];
    _reference = json['reference'];
    if (json['structured_formatting'] != null) {
      _structuredFormatting = [];
      json['structured_formatting'].forEach((v) {
        _structuredFormatting?.add(StructuredFormatting.fromJson(v));
      });
    }
  }

  String? _description;
  List<MatchedSubstrings>? _matchedSubstrings;
  String? _placeId;
  String? _reference;
  List<StructuredFormatting>? _structuredFormatting;

  String? get description => _description;

  List<MatchedSubstrings>? get matchedSubstrings => _matchedSubstrings;

  String? get placeId => _placeId;

  String? get reference => _reference;

  List<StructuredFormatting>? get structuredFormatting => _structuredFormatting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = _description;
    if (_matchedSubstrings != null) {
      map['matched_substrings'] =
          _matchedSubstrings?.map((v) => v.toJson()).toList();
    }
    map['place_id'] = _placeId;
    map['reference'] = _reference;
    if (_structuredFormatting != null) {
      map['structured_formatting'] =
          _structuredFormatting?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// main_text : "Amsterdam"
/// main_text_matched_substrings : [{"length":1,"offset":0}]
/// secondary_text : "Netherlands"

StructuredFormatting structuredFormattingFromJson(String str) =>
    StructuredFormatting.fromJson(json.decode(str));

String structuredFormattingToJson(StructuredFormatting data) =>
    json.encode(data.toJson());

class StructuredFormatting {
  StructuredFormatting({
    String? mainText,
    List<MainTextMatchedSubstrings>? mainTextMatchedSubstrings,
    String? secondaryText,
  }) {
    _mainText = mainText;
    _mainTextMatchedSubstrings = mainTextMatchedSubstrings;
    _secondaryText = secondaryText;
  }

  StructuredFormatting.fromJson(dynamic json) {
    _mainText = json['main_text'];
    if (json['main_text_matched_substrings'] != null) {
      _mainTextMatchedSubstrings = [];
      json['main_text_matched_substrings'].forEach((v) {
        _mainTextMatchedSubstrings?.add(MainTextMatchedSubstrings.fromJson(v));
      });
    }
    _secondaryText = json['secondary_text'];
  }

  String? _mainText;
  List<MainTextMatchedSubstrings>? _mainTextMatchedSubstrings;
  String? _secondaryText;

  String? get mainText => _mainText;

  List<MainTextMatchedSubstrings>? get mainTextMatchedSubstrings =>
      _mainTextMatchedSubstrings;

  String? get secondaryText => _secondaryText;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['main_text'] = _mainText;
    if (_mainTextMatchedSubstrings != null) {
      map['main_text_matched_substrings'] =
          _mainTextMatchedSubstrings?.map((v) => v.toJson()).toList();
    }
    map['secondary_text'] = _secondaryText;
    return map;
  }
}

/// length : 1
/// offset : 0

MainTextMatchedSubstrings mainTextMatchedSubstringsFromJson(String str) =>
    MainTextMatchedSubstrings.fromJson(json.decode(str));

String mainTextMatchedSubstringsToJson(MainTextMatchedSubstrings data) =>
    json.encode(data.toJson());

class MainTextMatchedSubstrings {
  MainTextMatchedSubstrings({
    int? length,
    int? offset,
  }) {
    _length = length;
    _offset = offset;
  }

  MainTextMatchedSubstrings.fromJson(dynamic json) {
    _length = json['length'];
    _offset = json['offset'];
  }

  int? _length;
  int? _offset;

  int? get length => _length;

  int? get offset => _offset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['length'] = _length;
    map['offset'] = _offset;
    return map;
  }
}

/// length : 1
/// offset : 0

MatchedSubstrings matchedSubstringsFromJson(String str) =>
    MatchedSubstrings.fromJson(json.decode(str));

String matchedSubstringsToJson(MatchedSubstrings data) =>
    json.encode(data.toJson());

class MatchedSubstrings {
  MatchedSubstrings({
    int? length,
    int? offset,
  }) {
    _length = length;
    _offset = offset;
  }

  MatchedSubstrings.fromJson(dynamic json) {
    _length = json['length'];
    _offset = json['offset'];
  }

  int? _length;
  int? _offset;

  int? get length => _length;

  int? get offset => _offset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['length'] = _length;
    map['offset'] = _offset;
    return map;
  }
}
