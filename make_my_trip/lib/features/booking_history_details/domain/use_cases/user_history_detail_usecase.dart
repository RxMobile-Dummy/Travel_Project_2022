
import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/booking_history_details/domain/repositories/user_history_detail_repository.dart';

import '../../../../core/failures/failures.dart';

class UserHistoryDetailUseCase{
  final UserHistoryDetailRepository userHistoryDetailRepository;
  UserHistoryDetailUseCase(this.userHistoryDetailRepository);

  Future<Either<Failures,String>> call(bookingId) async {
    return await userHistoryDetailRepository.cancelBooking(bookingId);
  }
}