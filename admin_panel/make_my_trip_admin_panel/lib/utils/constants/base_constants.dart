import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/base/base_state.dart';
import '../../core/failures/failures.dart';

class BaseConstant {
  static const String baseUrl = "http://192.168.102.190:4000/";

  static Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    printUserToken(userToken);
    return Options(headers: {'token': userToken});
  }

  static void printUserToken(String text) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }

  static checkFailures(Failures failure) {
    if (failure is InternetFailure) {
      return StateInternetError();
    } else if (failure is ErrorWithMessageFailure) {
      return StateErrorGeneral(failure.failureMsg);
    } else {
      return StateErrorGeneralStateErrorServer();
    }
  }
}
