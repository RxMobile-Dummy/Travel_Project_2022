part of 'push_notification_cubit.dart';

@immutable
abstract class PushNotificationState extends BaseState{}

class PushNotificationInitial extends PushNotificationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PushNotificationResponse extends PushNotificationState {
  String? fileName;
  String? refUrl;
  int? registerUser;
  int? endUser;
  PushNotificationResponse(
      [this.fileName, this.refUrl, this.registerUser, this.endUser]);

  @override
  // TODO: implement props
  List<Object?> get props => [fileName,refUrl,registerUser,endUser];
}

class ErrorState extends PushNotificationState {
  String error;
  ErrorState(this.error);

  @override
  // TODO: implement props
  List<Object?> get props =>[error];
}
