import 'package:get_it/get_it.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/data/data_sources/push_notification_datasource.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/data/data_sources/push_notification_datasource_impl.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/data/repositories/push_notification_repository_impl.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/domain/repositories/push_notification_repository.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/domain/use_cases/enduser_notification_usecase.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/domain/use_cases/push_notification_usecase.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/domain/use_cases/register_user_notification_usecase.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/presentation/cubit/push_notification_cubit.dart';

final slPushNotification = GetIt.instance;

Future<void> init() async {
  //cubit
  slPushNotification.registerFactory(() => PushNotificationCubit(
      slPushNotification(), slPushNotification(), slPushNotification()));

  //Data source
  slPushNotification.registerLazySingleton<PushNotificationDataSource>(
      () => PushNotificationDataSourceImpl(slPushNotification()));

  //Repository
  slPushNotification.registerLazySingleton<PushNotificationRepository>(
      () => PushNotificationRepositoryImpl(slPushNotification()));

  //Usecase
  slPushNotification.registerLazySingleton(
      () => PushNotificationUseCase(slPushNotification()));
  slPushNotification.registerLazySingleton(
      () => RegisterUserNotificationUseCase(slPushNotification()));
  slPushNotification.registerLazySingleton(
      () => EndUserNotificationUseCase(slPushNotification()));
}
