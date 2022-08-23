import 'dart:convert';

/// title : "abc"
/// subtitle : "abc"

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));
String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  FaqModel({
    this.title,
    this.subtitle,
  });

  FaqModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
  }
  String? title;
  String? subtitle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['subtitle'] = subtitle;
    return map;
  }
}
