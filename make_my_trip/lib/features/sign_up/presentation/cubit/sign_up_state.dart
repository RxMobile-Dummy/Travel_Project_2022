part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpError extends SignUpState {
  String error;
  SignUpError(this.error);
}
class RegisterSuccess extends SignUpState{
  String success_message;
  RegisterSuccess({required this.success_message});
}
class WaitingDialog extends SignUpState{
  bool waiting_dialog;
  WaitingDialog({required this.waiting_dialog});
}
