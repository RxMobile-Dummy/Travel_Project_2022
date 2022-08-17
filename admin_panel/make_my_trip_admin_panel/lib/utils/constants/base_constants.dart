import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/base/base_state.dart';
import '../../core/failures/failures.dart';

class BaseConstant {
  static const String baseUrl = "http://192.168.102.164:49455/";

  static Future<Options> createDioOptions() async {
    // final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    return Options(headers: {
      'token':
          "eyJhbGciOiJSUzI1NiIsImtpZCI6ImFkMWIxOWYwZjU4ZTJjOWE5Njc3M2M5MmNmODA0NDEwMTc5NzEzMjMiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQWRtaW4iLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vdHJhdmVscHJvamVjdDIyLTZiOWQ0IiwiYXVkIjoidHJhdmVscHJvamVjdDIyLTZiOWQ0IiwiYXV0aF90aW1lIjoxNjYwNzQ0NTg2LCJ1c2VyX2lkIjoiZHdra2Y1cTd1Zk9lWkNTcW81cU1CUjFzQTFGMiIsInN1YiI6ImR3a2tmNXE3dWZPZVpDU3FvNXFNQlIxc0ExRjIiLCJpYXQiOjE2NjA3NDQ1ODcsImV4cCI6MTY2MDc0ODE4NywiZW1haWwiOiJ0cmF2ZWxzeWFkbWluQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0cmF2ZWxzeWFkbWluQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.K2k9KEWs0TVd9mY96W52LKCUiSm5yIaJDqa1c9nPX_JYtcc6VpBTBNGjq2krfcmIe72kKe1bGeWYtY_Y0jmwiJO7vONiVDDXHY2pOWbH7UHmqpeatXk_oRCThhVg0U5PU-VabMe_Lfv6xOQrUFB_NOXXw-oPwHGqS4hmCIGuDT2WItSSkQyx6Yu6OCvn0C1HkSqnUkM5cnTrrocnthjt-Wqif0rvOWDvey7q0T9X8defggp8-bJCE_HdluJ5ZYlNwuOrQsi411nm7jKT4WoODeHlC9g7fbTmwkhJK5FxKueq5xFQxLcPoUDyupwtnVtm6GZiJOfP3nxnS2oHj8XFOA"
    });
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
