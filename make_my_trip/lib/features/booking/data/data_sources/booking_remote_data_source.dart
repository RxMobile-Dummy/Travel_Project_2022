import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';

import '../../../../core/failures/failure_handler.dart';
import '../../../../core/failures/failures.dart';
import '../../../../utils/constants/base_constants.dart';
import '../model/booking_model.dart';
import '../model/payment_model.dart';

abstract class BookingRemoteDataSource {
  Future<Either<Failures, PaymentModel>> paymentIntegerationDataSource(
      double amount);

  Future<Either<Failures, BookingModel>> bookingRemoteDataSource(int hotelId,
      String cIn, String cOut, List<int> roomId, int adults, int coupon_id);

  Future<Either<Failures, List<ViewCouponModel>>> showApplicableCoupons(
      int price);
  Future<Either<Failures, List<ViewCouponModel>>> checkCoupon(
      int price, String code);
      double amount,
      List<int> roomId,
      int hotelId,
      String cIn,
      String cOut,
      double roomPrice,
      int gst,
      int offer,
      int total,
      int couponId);
  Future<Either<Failures, BookingModel>> bookingRemoteDataSource(
      int hotelId, String cIn, String cOut, List<int> roomId, int adults);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final Dio dio;

  BookingRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, PaymentModel>> paymentIntegerationDataSource(
      double amount,
      List<int> roomId,
      int hotelId,
      String cIn,
      String cOut,
      double roomPrice,
      int gst,
      int offer,
      int total,
      int couponId) async {
    try {
      final response = await dio.post('${BaseConstant.baseUrl}payment',
          data: {
            'amount': amount,
            "room_id": roomId,
            "cin": cIn,
            "cout": cOut,
            "hotel_id": hotelId,
            "coupon_id": couponId,
            "price": {
              "room_price": roomPrice,
              "discount": offer,
              "gst": gst,
              "total_price": total,
            },
          },
          options: await BaseConstant.createDioOptions());
      final res = await FailureHandler.handleError(response);
      return res.fold((l) => Left(l), (r) {
        PaymentModel paymentModel;
        final data = response.data;
        paymentModel = PaymentModel.fromJson(data);
        return Right(paymentModel);
      });
    } on SocketException {
      return Left(InternetFailure());
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, BookingModel>> bookingRemoteDataSource(
      int hotelId,
      String cIn,
      String cOut,
      List<int> roomId,
      int adults,
      int coupon_id) async {
    try {
      final response =
          await dio.get('${BaseConstant.baseUrl}booking/roombooking/prize',
              queryParameters: {
                "hotelid": hotelId,
                "cin": cIn,
                "cout": cOut,
                "roomid": roomId.join(","),
                "adults": adults,
                "coupon_id": coupon_id
              },
              options: await BaseConstant.createDioOptions());
      final res = await FailureHandler.handleError(response);
      return res.fold((l) => Left(l), (r) {
        BookingModel bookingModel;
        final data = response.data;

        bookingModel = BookingModel.fromJson(data);
        return Right(bookingModel);
      });
    } on SocketException {
      return Left(InternetFailure());
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}


@override
  Future<Either<Failures, List<ViewCouponModel>>> showApplicableCoupons(
      int price) async {
    // TODO: implement showApplicableCoupons
    try {
      final response = await dio.get(
          '${BaseConstant.baseUrl}coupon/couponlistmostapplicable/',
          queryParameters: {"price": price},
          options: await BaseConstant.createDioOptions());
      var result = response.data;
      print('data');
      if (response.statusCode == 200) {
        List<ViewCouponModel> showApplicableCouponList = [];
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

  @override
  Future<Either<Failures, List<ViewCouponModel>>> checkCoupon(
      int price, String code) async {
    // TODO: implement checkCoupon
    try {
      final response = await dio.get('${BaseConstant.baseUrl}coupon/code/',
          queryParameters: {"price": price, "code": code},
          options: await BaseConstant.createDioOptions());
      var result = response.data;
      print('data');
      if (response.statusCode == 200) {
        List<ViewCouponModel> checkCouponList = [];
        {
          for (Map i in result) {
            checkCouponList.add(ViewCouponModel.fromJson(i));
          }
        }
        return Right(checkCouponList);
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
