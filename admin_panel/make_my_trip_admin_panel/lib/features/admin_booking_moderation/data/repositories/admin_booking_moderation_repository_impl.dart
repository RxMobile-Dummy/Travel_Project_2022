import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/data/data_sources/admin_booking_moderation_data_source.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/data/models/booking_moderation_model.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/domain/repositories/admin_booking_moderation_repository.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/domain/use_cases/admin_booking_moderation_use_cases.dart';

class AdminBookingModerationRepositoryImpl
    implements AdminBookingModerationRepository {
  final AdminBookingModerationDataSource adminBookingModerationDataSource;

  AdminBookingModerationRepositoryImpl(this.adminBookingModerationDataSource);

  @override
  Future<Either<Failures, List<BookingModerationModel>>> getAllBookings(
      FilterParams params) async {
    return await adminBookingModerationDataSource.getAllBookings(params);
  }
}
