import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BaseConstant {
  static const String baseUrl = "https://travelsybackend.herokuapp.com/";

  static Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    printWrapped(userToken);
    return Options(headers: {'token': userToken});
  }

  static void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  static const String uriPrefix = 'https://travelproject22.page.link';
}
