import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';

abstract class UserHistoryDetailDataSource {
  Future<Either<Failures,String>> cancelBooking(bookingId);
}