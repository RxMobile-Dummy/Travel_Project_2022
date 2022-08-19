part of 'push_notification_cubit.dart';

@immutable
abstract class PushNotificationState {}

class PushNotificationInitial extends PushNotificationState {}

class PushNotificationResponse extends PushNotificationState {
  String? fileName;
  String? refUrl;
  int? registerUser;
  int? endUser;
  PushNotificationResponse(
      [this.fileName, this.refUrl, this.registerUser, this.endUser]);
}

class ErrorState extends PushNotificationState {
  String error;
  ErrorState(this.error);
}
