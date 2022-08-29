import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/viewCoupon_datasource.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';

import '../../../../core/failures/failure_handler.dart';

class ViewCouponsDataSourceImpl implements ViewCouponsDataSource {
  final Dio dio;

  ViewCouponsDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, List<ViewCouponModel>>> getCouponsData() async {
    try {
      final response = await dio.get('${BaseConstant.baseUrl}coupon/coupon',
          options: await BaseConstant.createDioOptions());
      var result = response.data;
      final res = await FailureHandler.handleError(response);
      return res.fold((l) => Left(l), (r) {
        List<ViewCouponModel> viewCouponList = [];

        for (var i in result) {
          viewCouponList.add(ViewCouponModel.fromJson(i));
        }

        return Right(viewCouponList);
      });
    } on SocketException {
      return Left(InternetFailure());
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, ViewCouponModel>> getCouponId(int id) async {
    try {
      final response = await dio.get(
          '${BaseConstant.baseUrl}coupon/coupon/${id}',
          options: await BaseConstant.createDioOptions());
      final res = await FailureHandler.handleError(response);
      return res.fold((l) => Left(l), (r) {
        ViewCouponModel viewCouponList = response.data[0];
        return Right(viewCouponList);
      });
    } on SocketException {
      return Left(InternetFailure());
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
