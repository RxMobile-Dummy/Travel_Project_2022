import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';
import '../model/user_history_model.dart';

import '../../../../core/failures/failure_handler.dart';

abstract class UserHistoryDataSource {
  Future<Either<Failures, List<UserHistoryModel>>> getUserHistoryData(int page);
}

class UserHistoryDataSourceImpl implements UserHistoryDataSource {
  final Dio dio;

  UserHistoryDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, List<UserHistoryModel>>> getUserHistoryData(
      page) async {
    try {
      final params = <String, dynamic>{
        'pagesize': 6,
        'page': page,
      };
      final response = await dio.get(
        '${BaseConstant.baseUrl}booking/user/bookings',
        options: await BaseConstant.createDioOptions(),
        queryParameters: params,
      );
      final res = await FailureHandler.handleError(response);
      return res.fold((l) => Left(l), (r) {
        List<UserHistoryModel> userHistoryModel = [];

        final apidata = r.data;
        for (var item in apidata) {
          userHistoryModel.add(UserHistoryModel.fromJson(item));
        }
        return Right(userHistoryModel);
      });
    } on SocketException {
      return Left(InternetFailure());
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
