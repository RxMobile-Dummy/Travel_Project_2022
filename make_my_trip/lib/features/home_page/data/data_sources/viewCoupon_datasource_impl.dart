import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/viewCoupon_datasource.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';

class ViewCouponsDataSourceImpl implements ViewCouponsDataSource {
  final Dio dio;

  ViewCouponsDataSourceImpl(this.dio);

  Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    return Options(headers: {'token': userToken});
  }

  @override
  Future<Either<Failures, List<ViewCouponModel>>> getCouponsData() async {
    try {
      final response = await dio.get('${BaseConstant.baseUrl}coupon/coupon',
          options: await createDioOptions());
      var result = response.data;
      if (response.statusCode == 200) {
        List<ViewCouponModel> viewCouponList = [];
        {
          for (Map i in result) {
            viewCouponList.add(ViewCouponModel.fromJson(i));
          }
        }
        return Right(viewCouponList);
      } else if (response.statusCode == 505) {
        return Left(ServerFailure());
      } else if (response.statusCode == 404) {
        return Left(
            AuthFailure()); //Data Not Found Failure but in failure there is no method so AuthFailure
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      print(e);
      return Left(ServerFailure(statusCode: "503"));
    }
  }

  @override
  Future<Either<Failures, ViewCouponModel>> getCouponId(int id) async {
    try {
      final response = await dio.get(
          '${BaseConstant.baseUrl}coupon/coupon/${id}',
          options: await createDioOptions());
      //var result = response.data;
      if (response.statusCode == 200) {
        ViewCouponModel viewCouponList = response.data[0];

        return Right(viewCouponList);
      } else if (response.statusCode == 505) {
        return Left(ServerFailure());
      } else if (response.statusCode == 404) {
        return Left(
            AuthFailure()); //Data Not Found Failure but in failure there is no method so AuthFailure
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      print(e);
      return Left(ServerFailure(statusCode: "503"));
    }
  }
}
