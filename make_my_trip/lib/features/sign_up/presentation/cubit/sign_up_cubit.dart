import 'package:bloc/bloc.dart';
import 'package:make_my_trip/utils/validators/user_info/user_information_validations.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  checkSignUp(String fullName, String email, String password, String conPass) {
    var resname = UserInfoValidation.nameValidation(fullName);
    if (resname == null) {
      var resemail = UserInfoValidation.emailAddressValidation(email);
      if (resemail == null) {
        if (password.isEmpty == false || password.length > 6) {
          if (password == conPass) {
            emit(SignUpSuccess());
          } else {
            emit(SignUpError('*Password does not match'));
          }
        } else {
          emit(SignUpError('*Password is weak'));
        }
      } else {
        emit(SignUpError('*Enter valid email'));
      }
    } else {
      emit(SignUpError('*Enter your name properly!'));
    }
  }
}
