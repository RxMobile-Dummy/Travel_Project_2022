import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';

abstract class PushNotificationRepository {
  Future<Either<Failures, List<dynamic>>> getImageFromDevice();
  Future<Either<Failures, String>> registerUserNotificationUseCase(
      title, body, url);
  Future<Either<Failures, String>> endUserNotificationUseCase(title, body, url);
}
