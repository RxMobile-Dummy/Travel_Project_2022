import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/booking/data/data_sources/booking_remote_data_source.dart';
import 'package:make_my_trip/features/booking/data/model/payment_model.dart';
import 'package:make_my_trip/features/booking/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {

  final BookingRemoteDataSource bookingRemoteDataSource;
  BookingRepositoryImpl(this.bookingRemoteDataSource);

  @override
  Future<Either<Failures, PaymentModel>> getPaymentDetails(double price) {
   return bookingRemoteDataSource.paymentIntegerationDataSource(price);
  }

}