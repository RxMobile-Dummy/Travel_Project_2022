import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/core/usecases/usecase.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/data/models/booking_moderation_model.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/domain/repositories/admin_booking_moderation_repository.dart';

class AdminBookingModerationUseCases
    extends UseCase<List<BookingModerationModel>, FilterParams> {
  final AdminBookingModerationRepository adminBookingModerationRepository;

  AdminBookingModerationUseCases(this.adminBookingModerationRepository);

  @override
  Future<Either<Failures, List<BookingModerationModel>>> call(
      FilterParams params) async {
    return await adminBookingModerationRepository.getAllBookings(params);
  }
}

class FilterParams extends Equatable {
  final int page;
  final String date1;
  final String date2;
  final String hotelname;
  final String username;

  const FilterParams(
      {required this.page,
      required this.date1,
      required this.date2,
      required this.hotelname,
      required this.username});

  @override
  List<Object?> get props => [page, date1, date2, hotelname, username];
}
