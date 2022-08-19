import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/failures/failures.dart';
import '../../../../utils/constants/base_constants.dart';
import '../model/booking_model.dart';
import '../model/payment_model.dart';

abstract class BookingRemoteDataSource {
  Future<Either<Failures, PaymentModel>> paymentIntegerationDataSource(
      double amount,List<int> roomId,int hotelId,String cIn,String cOut,  double roomPrice, int gst, int offer, int total, int couponId );
  Future<Either<Failures, BookingModel>> bookingRemoteDataSource(
      int hotelId, String cIn, String cOut, List<int> roomId, int adults);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final Dio dio;
  BookingRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, PaymentModel>> paymentIntegerationDataSource(
      double amount,List<int> roomId,int hotelId,String cIn,String cOut, double roomPrice, int gst, int offer, int total, int couponId) async {
    try {
      final response = await dio.post('${BaseConstant.baseUrl}payment',
          data: {'amount': amount,"room_id":roomId,"cin":cIn,"cout":cOut,"hotel_id":hotelId,"coupon_id":couponId,"price":{
            "room_price":roomPrice,
            "offer":offer,
            "gst":gst,
            "total":total,
          },
          },
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
                "adults": adults,
                "coupon_id":2
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
}
