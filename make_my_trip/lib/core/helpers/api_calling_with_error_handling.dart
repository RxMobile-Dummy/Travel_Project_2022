import 'dart:convert' as convert;
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../failures/failures.dart';

/// use this class while calling the api from your data source impl
class ApiCallingWithError<T> {
  ApiCallingWithError();

  Stream<Either<Failures, T>> callApi(
    Future callApi,
  ) {
    return Stream.fromFuture(Connectivity().checkConnectivity())
        .flatMap((result) {
      return Stream.fromFuture(callApi).onErrorReturnWith((e, s) {
        if (e is SocketException) {
          return InternetFailure();
        }
        if (e is HttpException) {
          return ServerFailure();
        } else if (e is DioError) {
          DioError d = e;
          if (d.response?.statusCode == 401) {
            return AuthFailure();
          } else {
            return ServerFailure();
          }
        } else {
          return ServerFailure();
        }
      }).flatMap((data) {
        return Stream.fromFuture(Connectivity().checkConnectivity())
            .flatMap((result) {
          if (result == ConnectivityResult.none) {
            return Stream.value(Left(InternetFailure()));
          } else {
            if (data is Response && data.statusCode == 400) {
              return Stream.value(
                      convert.jsonDecode(data.statusMessage.toString()))
                  .flatMap((data) {
                if (data is List) {
                  List<String> stringList = data.cast<String>();
                  return Stream.value(
                      Left(ErrorWithMessageFailure(stringList.first)));
                } else if (data is Map && data["errors"] != null) {
                  return Stream.value(Left(ErrorWithMessageFailure(
                      'unknown error caught in data conversion.')));
                } else {
                  return Stream.value(
                      Left(ErrorWithMessageFailure('unknown error occurred.')));
                }
              });
            } else if (data is Response && data.statusCode == 500) {
              return Stream.value(Left(ServerFailure()));
            } else if (data is Response && data.statusCode == 401) {
              return Stream.value(Left(AuthFailure()));
            } else if (data is Response && data.statusCode == 404) {
              return Stream.value(Left(ServerFailure()));
            } else if (data is Response && data.statusCode == 401) {
              return Stream.value(Left(AuthFailure()));
            } else if (data is Response && data.statusCode == 403) {
              return Stream.value(Left(ErrorWithMessageFailure(
                  "Sorry! you don't have right to access.")));
            } else if (data is Exception) {
              return Stream.error(data);
            } else {
              return Stream.value(Right(data));
            }
          }
        });
      });
    });
  }
}
