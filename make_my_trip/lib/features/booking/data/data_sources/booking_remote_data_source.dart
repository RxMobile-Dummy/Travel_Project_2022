import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/failures/failures.dart';
import '../model/payment_model.dart';

abstract class BookingRemoteDataSource {
  Future<Either<Failures, PaymentModel>> paymentIntegerationDataSource(
      double amount);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final Dio dio;
  BookingRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, PaymentModel>> paymentIntegerationDataSource(
      double amount) async {
    try {
      final response = await dio.post(
          'https://cfb2-180-211-112-179.in.ngrok.io/payment',
          data: {'amount': amount});
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
}
