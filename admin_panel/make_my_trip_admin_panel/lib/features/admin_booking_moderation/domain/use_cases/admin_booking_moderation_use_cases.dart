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
  final int? page;
  final String? checkInDate;
  final String? checkOutDate;
  final String? hotelname;
  final String? username;

  const FilterParams(
      {required this.page,
      this.checkInDate,
      this.checkOutDate,
      this.hotelname,
      this.username});

  @override
  List<Object?> get props =>
      [page, checkInDate, checkOutDate, hotelname, username];
}
