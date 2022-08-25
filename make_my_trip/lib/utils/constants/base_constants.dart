import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BaseConstant {
  static const String baseUrl = "https://906d-180-211-112-179.in.ngrok.io/";

  static Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    return Options(headers: {'token': userToken});
  }

  static const String uriPrefix = 'https://travelproject22.page.link';
}
