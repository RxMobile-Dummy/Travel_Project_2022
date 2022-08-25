import 'package:get_it/get_it.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/data/data_sources/admin_booking_moderation_data_source.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/data/data_sources/admin_booking_moderation_data_source_impl.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/data/repositories/admin_booking_moderation_repository_impl.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/domain/repositories/admin_booking_moderation_repository.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/domain/use_cases/admin_booking_moderation_use_cases.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/presentation/cubit/admin_booking_moderation_cubit.dart';

final slBookingModeration = GetIt.instance;

Future<void> init() async {
  //cubit
  slBookingModeration.registerFactory(
      () => AdminBookingModerationCubit(slBookingModeration()));

  //Data source
  slBookingModeration.registerLazySingleton<AdminBookingModerationDataSource>(
      () => AdminBookingModerationDataSourceImpl(slBookingModeration()));

  //Repository
  slBookingModeration.registerLazySingleton<AdminBookingModerationRepository>(
      () => AdminBookingModerationRepositoryImpl(slBookingModeration()));

  //Usecase
  slBookingModeration.registerLazySingleton(
      () => AdminBookingModerationUseCases(slBookingModeration()));
}
