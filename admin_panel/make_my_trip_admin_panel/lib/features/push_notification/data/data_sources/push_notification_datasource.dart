import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';

abstract class PushNotificationDataSource{
  Future<Either<Failures,List<dynamic>>> getImageFromDevice();
}
