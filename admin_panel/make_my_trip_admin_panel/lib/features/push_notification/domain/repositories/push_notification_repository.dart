import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';

abstract class PushNotificationRepository{
  Future<Either<Failures,List<dynamic>>> getImageFromDevice();
}