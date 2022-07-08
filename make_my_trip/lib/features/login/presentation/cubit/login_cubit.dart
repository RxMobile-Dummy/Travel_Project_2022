import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void changeObSecureEvent(bool obSecure) {
    emit(ChangeState(!obSecure));
  }
}
