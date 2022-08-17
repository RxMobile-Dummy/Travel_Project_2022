import 'dart:convert';

ContentModel contentModelFromJson(String str) => ContentModel.fromJson(json.decode(str));
String contentModelToJson(ContentModel data) => json.encode(data.toJson());

class ContentModel {
  ContentModel({
      this.title,});

  ContentModel.fromJson(dynamic json) {
    title = json['title'];
  }
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    return map;
  }

}