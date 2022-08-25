import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../base/base_state.dart';
import 'failures.dart';

class FailureHandler {
  static Future<Either<Failures, Response<dynamic>>> handleError(
      Response<dynamic> response) async {
    switch (response.statusCode) {
      case 200:
        return Right(response);
      case 401:
        return Left(AuthFailure());

      default:
        return Left(ServerFailure(failureMsg: "Unexpected Error"));
    }
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
