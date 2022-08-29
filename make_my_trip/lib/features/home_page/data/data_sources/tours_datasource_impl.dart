import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/tours_datasource.dart';
import '../../../../core/failures/failure_handler.dart';
import '../../../../core/failures/failures.dart';
import '../../../../utils/constants/base_constants.dart';
import '../models/ToursModel.dart';

class ToursDataSourceImpl implements ToursDataSource {
  final Dio dio;

  ToursDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, List<ToursModel>>> getToursData() async {
    try {
      final response = await dio.get('${BaseConstant.baseUrl}tour/5',
          options: await BaseConstant.createDioOptions());

      final res = await FailureHandler.handleError(response);
      return res.fold((l) => Left(l), (r) {
        List<ToursModel> postList = [];
        {
          for (Map i in response.data) {
            postList.add(ToursModel.fromJson(i));
          }
        }
        return Right(postList);
      });
    } on SocketException {
      return Left(InternetFailure());
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
