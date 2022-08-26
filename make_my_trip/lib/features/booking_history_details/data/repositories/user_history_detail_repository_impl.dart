import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/booking_history_details/data/data_sources/user_history_detail_datasource.dart';
import 'package:make_my_trip/features/booking_history_details/domain/repositories/user_history_detail_repository.dart';

class UserHistoryDetailRepositoryImpl extends UserHistoryDetailRepository {
  UserHistoryDetailDataSource userHistoryDetailDataSource;
  UserHistoryDetailRepositoryImpl(this.userHistoryDetailDataSource);
  @override
  Future<Either<Failures, String>> cancelBooking(bookingId) async {
    return await userHistoryDetailDataSource.cancelBooking(bookingId);
  }
}
