import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';

import '../../../../core/failures/failures.dart';
import '../../../../utils/constants/base_constants.dart';
import '../model/booking_model.dart';
import '../model/payment_model.dart';

abstract class BookingRemoteDataSource {
  Future<Either<Failures, PaymentModel>> paymentIntegerationDataSource(
      double amount);
  Future<Either<Failures, BookingModel>> bookingRemoteDataSource(
      int hotelId, String cIn, String cOut, List<int> roomId, int adults);
  Future<Either<Failures, List<ViewCouponModel>>> showApplicableCoupons(int price);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final Dio dio;
  BookingRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, PaymentModel>> paymentIntegerationDataSource(
      double amount) async {
    try {
      final response = await dio.post('${BaseConstant.baseUrl}payment',
          data: {'amount': amount},
          options: await BaseConstant.createDioOptions());
      if (response.statusCode == 200) {
        PaymentModel paymentModel;
        final data = response.data;
        paymentModel = PaymentModel.fromJson(data);
        return Right(paymentModel);
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, BookingModel>> bookingRemoteDataSource(int hotelId,
      String cIn, String cOut, List<int> roomId, int adults) async {
    try {
      final response =
          await dio.get('${BaseConstant.baseUrl}booking/roombooking/prize',
              queryParameters: {
                "hotelid": hotelId,
                "cin": cIn,
                "cout": cOut,
                "roomid": roomId.join(","),
                "adults": adults
              },
              options: await BaseConstant.createDioOptions());
      if (response.statusCode == 200) {
        BookingModel bookingModel;
        final data = response.data;

        bookingModel = BookingModel.fromJson(data);
        return Right(bookingModel);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, List<ViewCouponModel>>> showApplicableCoupons(int price) async{
    // TODO: implement showApplicableCoupons
    try {
      final response = await dio.get(
          '${BaseConstant.baseUrl}coupon/couponlistmostapplicable/',
          queryParameters: {
            "price":price
          },
          options: await BaseConstant.createDioOptions());
    var result = response.data;
    print('data');
    print(result);
    if (response.statusCode == 200) {
    List <ViewCouponModel> showApplicableCouponList = [];
    {
      for (Map i in result) {
        showApplicableCouponList.add(ViewCouponModel.fromJson(i));
      }
    }

    return Right(showApplicableCouponList);
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
