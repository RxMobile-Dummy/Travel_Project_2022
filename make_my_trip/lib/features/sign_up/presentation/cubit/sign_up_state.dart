part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String error;
  SignUpErrorState({required this.error});
}

class SignUpSuccessState extends SignUpState {}

class SignUpPassEyeState extends SignUpState {
  final bool val;
  SignUpPassEyeState({required this.val});
}

class SignUpConPassEyeState extends SignUpState {
  final bool val;
  SignUpConPassEyeState({required this.val});
}

class WaitingDialog extends SignUpState {}
