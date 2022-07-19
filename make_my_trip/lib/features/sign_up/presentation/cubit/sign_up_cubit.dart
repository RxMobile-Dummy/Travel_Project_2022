
import 'package:bloc/bloc.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/sign_up/domain/usecases/user_sign_up.dart';
import 'package:make_my_trip/features/sign_up/domain/usecases/user_verification.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/validators/user_info/user_information_validations.dart';
import 'package:meta/meta.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.userVerification, required this.userSignUp})
      : super(SignUpInitial());
  final UserSignUp userSignUp;
  final UserVerification userVerification;

  showWaitingDialog() {
    emit(WaitingDialog());
  }

  signUpWithEmail(
      {required String signUpEmail,
      required String signUpPassword,
      required String signUpFullname,
      required String signUpConfirmPassword}) async {
    final nameValidation = UserInfoValidation.nameValidation(signUpFullname);
    if (nameValidation != null) {
      emit(SignUpErrorState(error: nameValidation));
    } else {
      final emailValidation =
          UserInfoValidation.emailAddressValidation(signUpEmail);
      if (emailValidation != null) {
        emit(SignUpErrorState(error: emailValidation));
      } else {
        final passwordValidation =
            UserInfoValidation.passwordValidation(signUpPassword);
        if (passwordValidation != null) {
          emit(SignUpErrorState(error: passwordValidation));
        } else {
          if (signUpConfirmPassword != signUpPassword) {
            emit(SignUpErrorState(
                error: StringConstants.messageInvalidConfirmPassword));
          } else {
            final response = await userSignUp.call(
                signUpFullname, signUpEmail, signUpPassword);
            response.fold((failure) {
              emit(SignUpErrorState(error: getFailure(failure)));
            }, (success) async {
              showWaitingDialog();
              final response = await userVerification.call();
              response.fold((failure) {
                emit(SignUpErrorState(error: getFailure(failure)));
              }, (success) {
                emit(SignUpSuccessState());
              });
            });
          }
        }
      }
    }
  }

  String getFailure(failure) {
    if (failure is ServerFailure) {
      return failure.failureMsg!;
    } else {
      if (failure is AuthFailure) {
        return failure.failureMsg!;
      } else {
        return "Unexpected Error";
      }
    }
  }
}
