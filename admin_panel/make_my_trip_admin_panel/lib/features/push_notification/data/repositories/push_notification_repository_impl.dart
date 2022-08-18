import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/data/data_sources/push_notification_datasource.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/domain/repositories/push_notification_repository.dart';

class PushNotificationRepositoryImpl
    implements PushNotificationRepository {
  final PushNotificationDataSource pushNotificationDataSource;

  PushNotificationRepositoryImpl(this.pushNotificationDataSource);

  @override
  Future<Either<Failures, List<dynamic>>> getImageFromDevice() async{
   return await pushNotificationDataSource.getImageFromDevice();
  }
}