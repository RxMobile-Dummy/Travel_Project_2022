part of 'push_notification_cubit.dart';

@immutable
abstract class PushNotificationState {}

class PushNotificationInitial extends PushNotificationState {}


class PushNotificationResponse extends PushNotificationState {
  String fileName;
  String refurl;
  PushNotificationResponse(this.fileName,this.refurl);
}
