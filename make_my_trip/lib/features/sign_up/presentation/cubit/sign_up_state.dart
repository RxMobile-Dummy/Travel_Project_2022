part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String error;
  SignUpErrorState({required this.error});
}

class SignUpSuccessState extends SignUpState {}

class WaitingDialog extends SignUpState {}
