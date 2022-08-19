import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';

abstract class PushNotificationDataSource {
  Future<Either<Failures, List<dynamic>>> getImageFromDevice();
  Future<Either<Failures, String>> registeredUserUseCase(title, body, url);
  Future<Either<Failures, String>> endUserUseCase(title, body, url);
}
