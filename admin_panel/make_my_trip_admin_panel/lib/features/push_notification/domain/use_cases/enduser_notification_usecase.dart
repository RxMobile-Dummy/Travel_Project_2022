import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../repositories/push_notification_repository.dart';

class EndUserNotificationUseCase {
  final PushNotificationRepository pushNotificationRepository;

  EndUserNotificationUseCase(this.pushNotificationRepository);

  Future<Either<Failures, String>> call(title, body, url) async {
    return await pushNotificationRepository.endUserNotificationUseCase(
        title, body, url);
  }
}
