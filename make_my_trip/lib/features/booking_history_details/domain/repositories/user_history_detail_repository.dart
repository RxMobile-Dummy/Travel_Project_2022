import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';

abstract class UserHistoryDetailRepository {
  Future<Either<Failures, String>> cancelBooking(bookingId);
}
