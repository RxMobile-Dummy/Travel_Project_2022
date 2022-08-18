import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/domain/repositories/push_notification_repository.dart';

import '../../../../core/failures/failures.dart';

class PushNotificationUseCase{
  final PushNotificationRepository pushNotificationRepository;

  PushNotificationUseCase(this.pushNotificationRepository);

  Future<Either<Failures,List<dynamic>>> call() async {
    return await pushNotificationRepository.getImageFromDevice();
  }
}