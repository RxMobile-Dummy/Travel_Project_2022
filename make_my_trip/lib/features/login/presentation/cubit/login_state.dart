part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class ChangeState extends LoginState {
  final bool obSecure;

  ChangeState(this.obSecure);
}
