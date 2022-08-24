import 'dart:convert';

ContentModel contentModelFromJson(String str) =>
    ContentModel.fromJson(json.decode(str));
String contentModelToJson(ContentModel data) => json.encode(data.toJson());

class ContentModel {
  ContentModel({this.title, this.subtitle});

  ContentModel.fromJson(dynamic json) {
    title = json['title'];
    subtitle = json['subtitle'] ?? null;
  }
  String? title;
  String? subtitle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['subtitle'] = subtitle ?? null;
    return map;
  }

  @override
  String toString() {
    return 'ContentModel{title: $title}';
  }
}
