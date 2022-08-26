import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../repositories/push_notification_repository.dart';

class RegisterUserNotificationUseCase {
  final PushNotificationRepository pushNotificationRepository;

  RegisterUserNotificationUseCase(this.pushNotificationRepository);

  Future<Either<Failures, String>> call(title, body, url) async {
    return await pushNotificationRepository.registerUserNotificationUseCase(
        title, body, url);
  }
}
