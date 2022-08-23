import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/base/base_state.dart';
import '../../core/failures/failures.dart';

class BaseConstant {
  // static const String baseUrl = "https://db55-180-211-112-179.in.ngrok.io/";
  static const String baseUrl = "http://192.168.102.79:10000/";

  static Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken(true);
    return Options(headers: {'token': userToken});
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
