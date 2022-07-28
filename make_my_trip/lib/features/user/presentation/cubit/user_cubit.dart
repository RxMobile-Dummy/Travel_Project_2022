import 'package:bloc/bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_facebook_login.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_forget_password.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_google_login.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_sign_in.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_sign_out.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_sign_up.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_verification.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/validators/user_info/user_information_validations.dart';

class UserCubit extends Cubit<BaseState> {
  UserCubit(
      {required this.googleLogin,
      required this.signIn,
      required this.facebookLogin,
      required this.forgetPassword,
      required this.userSignUp,
      required this.userVerification,
      required this.userSignOut})
      : super(StateInitial());
  final UserGoogleLogin googleLogin;
  final UserSignIn signIn;
  final UserFacebookLogin facebookLogin;
  final UserForgetPassword forgetPassword;
  final UserSignUp userSignUp;
  final UserVerification userVerification;
  final UserSignOut userSignOut;

  // login and sign_up password obSecure change event
  void changeObSecureEvent(bool obSecure) {
    emit(StateOnKnownToSuccess(!obSecure));
  }

  // google login event
  signInWithGoogle() async {
    emit(StateLoading());
    final res = await googleLogin.call(NoParams());
    res.fold((failure) {
      if (failure is AuthFailure) {
        emit(StateErrorGeneral(failure.failureMsg!));
      } else {
        emit(StateErrorGeneral(""));
      }
    }, (success) {
      emit(StateOnSuccess("success"));
    });
  }

  // login with email & password event
  signInWithEmail(String loginEmail, String loginPassword) async {
    emit(StateLoading());
    final emailValidation =
        UserInfoValidation.emailAddressValidation(loginEmail);
    if (emailValidation != null) {
      emit(StateErrorGeneral(emailValidation));
    } else {
      final passwordValidation =
          UserInfoValidation.passwordValidation(loginPassword);
      if (passwordValidation != null) {
        emit(StateErrorGeneral(passwordValidation));
      } else {
        final res = await signIn.call(UserSignInParams(
            userEmail: loginEmail, userPassword: loginPassword));

        res.fold((failure) {
          if (failure is AuthFailure) {
            emit(StateErrorGeneral(failure.failureMsg!));
          }
        }, (success) {
          emit(StateOnSuccess("success"));
        });
      }
    }
  }

  // facebook login event
  signInWithFacebook() async {
    final res = await facebookLogin.call(NoParams());
    res.fold((failure) {
      if (failure is AuthFailure) {
        emit(StateErrorGeneral(failure.failureMsg!));
      }
    }, (success) {
      emit(StateOnSuccess("success"));
    });
  }

  // forgot password event
  userForgetPassword(String emailData) async {
    final emailValidation =
        UserInfoValidation.emailAddressValidation(emailData);
    if (emailValidation != null) {
      emit(StateErrorGeneral(emailValidation));
    } else {
      final res = await forgetPassword.call(UserForgetParam(email: emailData));
      res.fold((failure) {
        if (failure is AuthFailure) {
          emit(StateErrorGeneral(failure.failureMsg!));
        }
      }, (success) {
        emit(StateOnSuccess("success"));
      });
    }
  }

  // conform password change obSecure event
  conPassEyeChange(bool val) {
    emit(StateOnResponseSuccess(!val));
  }

  //
  showWaitingDialog() {
    emit(StateShowSearching());
  }

  // sign_up with email & password event
  signUpWithEmail(
      {required String signUpEmail,
      required String signUpPassword,
      required String signUpFullName,
      required String signUpConfirmPassword}) async {
    final nameValidation = UserInfoValidation.nameValidation(signUpFullName);
    if (nameValidation != null) {
      emit(StateErrorGeneral(nameValidation));
    } else {
      final emailValidation =
          UserInfoValidation.emailAddressValidation(signUpEmail);
      if (emailValidation != null) {
        emit(StateErrorGeneral(emailValidation));
      } else {
        final passwordValidation =
            UserInfoValidation.passwordValidation(signUpPassword);
        if (passwordValidation != null) {
          emit(StateErrorGeneral(passwordValidation));
        } else {
          if (signUpConfirmPassword != signUpPassword) {
            emit(StateErrorGeneral(
                StringConstants.messageInvalidConfirmPassword));
          } else {
            final response = await userSignUp.call(
                signUpFullName, signUpEmail, signUpPassword);
            response.fold((failure) {
              emit(StateErrorGeneral(_getFailure(failure)));
            }, (success) async {
              showWaitingDialog();
              // final response = await userVerification.call();
              // response.fold((failure) {
              //   emit(StateErrorGeneral(_getFailure(failure)));
              // }, (success) {
              //   emit(StateOnSuccess("success"));
              // });
            });
          }
        }
      }
    }
  }

  // failures
  String _getFailure(failure) {
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

  // user sign_out event
  userSignOutEvent() async {
    final res = await userSignOut.call(NoParams());
    res.fold((failure) {
      emit(StateErrorGeneral("Logout Error"));
    }, (success) {
      emit(StateOnSuccess("Logout success"));
    });
  }
}
