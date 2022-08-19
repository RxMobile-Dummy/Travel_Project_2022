import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BaseConstant {
  static const String baseUrl = "https://b064-180-211-112-179.in.ngrok.io/";

  static Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    printUserToken(userToken);
    return Options(headers: {'token': userToken});
  }

  static void printUserToken(String text) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }

}
