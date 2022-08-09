import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/failures/failures.dart';
import '../../../../utils/constants/base_constants.dart';
import '../model/booking_model.dart';
import '../model/payment_model.dart';

abstract class BookingRemoteDataSource {
  Future<Either<Failures, PaymentModel>> paymentIntegerationDataSource(
      double amount);
  Future<Either<Failures, BookingModel>> bookingRemoteDataSource(
      int hotelId, String cIn, String cOut, List<int> roomId);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final Dio dio;
  BookingRemoteDataSourceImpl(this.dio);

  Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    print("hello");
    printWrapped(userToken);
    return Options(headers: {'token': userToken});
  }

  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  @override
  Future<Either<Failures, PaymentModel>> paymentIntegerationDataSource(
      double amount) async {
    try {
      final response = await dio.post('${BaseConstant.baseUrl}payment',
          data: {'amount': amount}, options: await createDioOptions());
      if (response.statusCode == 200) {
        PaymentModel paymentModel;
        final data = response.data;
        paymentModel = PaymentModel.fromJson(data);
        return Right(paymentModel);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, BookingModel>> bookingRemoteDataSource(
      int hotelId, String cIn, String cOut, List<int> roomId) async {
    try {
      final response = await dio.get(
          '${BaseConstant.baseUrl}booking/roombooking/prize',
          queryParameters: {
            "hotelid": hotelId,
            "cin": cIn,
            "cout": cOut,
            "roomid": roomId.join(",")
          },
          options: await createDioOptions());
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
