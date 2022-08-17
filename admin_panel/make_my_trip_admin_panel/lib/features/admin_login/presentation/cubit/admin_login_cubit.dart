import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/utils/validations/user_info/user_information_validations.dart';

class AdminLoginCubit extends Cubit<BaseState> {
  AdminLoginCubit() : super(StateInitial());

  void changeObSecureEvent(bool obSecureValue) {
    emit(StateOnSuccess(!obSecureValue));
  }

  void emailValidationEvent(String email) {
    final emailValidation = UserInfoValidation.emailAddressValidation(email);
    if (emailValidation != null) {
      emit(ValidationError("email is not valid!"));
    } else {
      emit(StateOnKnownToSuccess("perfect!"));
    }
  }

  void passwordValidationEvent(String password) {
    final passValidation = UserInfoValidation.passwordValidation(password);
    if (passValidation != null) {
      emit(StateErrorGeneral("password is not strong!"));
    } else {
      emit(StateOnResponseSuccess("done!"));
    }
  }

  void signInWithEmailAndPassword(String email, String password) {
  }
}
