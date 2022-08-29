import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';

import '../../../../core/failures/failure_handler.dart';
import '../../../../core/failures/failures.dart';
import '../../../../utils/constants/base_constants.dart';
import '../model/booking_model.dart';
import '../model/payment_model.dart';

abstract class BookingRemoteDataSource {
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
      int couponId);
  Future<Either<Failures, BookingModel>> bookingRemoteDataSource(int hotelId,
      String cIn, String cOut, List<int> roomId, int adults, int couponId);
  Future<Either<Failures, List<ViewCouponModel>>> showApplicableCoupons(
      int price);
  Future<Either<Failures, List<ViewCouponModel>>> checkCoupon(
      int price, String code);
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

  Future<Either<Failures, List<ViewCouponModel>>> showApplicableCoupons(
      int price) async {
    try {
      final response = await dio.get(
          '${BaseConstant.baseUrl}coupon/couponlistmostapplicable/',
          queryParameters: {"price": price},
          options: await BaseConstant.createDioOptions());
      var result = response.data;
      final res = await FailureHandler.handleError(response);
      return res.fold((l) => Left(l), (r) {
        List<ViewCouponModel> showApplicableCouponList = [];
        for (Map i in result) {
          showApplicableCouponList.add(ViewCouponModel.fromJson(i));
        }
        print(showApplicableCouponList);
        return Right(showApplicableCouponList);
      });
    } on SocketException {
      return Left(InternetFailure());
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, List<ViewCouponModel>>> checkCoupon(
      int price, String code) async {
    try {
      final response = await dio.get('${BaseConstant.baseUrl}coupon/code/',
          queryParameters: {"price": price, "code": code},
          options: await BaseConstant.createDioOptions());
      var result = response.data;
      final res = await FailureHandler.handleError(response);
      return res.fold((l) => Left(l), (r) {
        List<ViewCouponModel> checkCouponList = [];
        {
          for (Map i in result) {
            checkCouponList.add(ViewCouponModel.fromJson(i));
          }
        }
        return Right(checkCouponList);
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
      int couponId) async {
    try {
      final response =
          await dio.get('${BaseConstant.baseUrl}booking/roombooking/prize',
              queryParameters: {
                "hotelid": hotelId,
                "cin": cIn,
                "cout": cOut,
                "roomid": roomId.join(","),
                "adults": adults,
                "coupon_id": couponId
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
