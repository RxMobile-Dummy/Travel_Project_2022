import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/login/domain/usecases/user_facebook_login.dart';
import 'package:make_my_trip/features/login/domain/usecases/user_forget_password.dart';
import 'package:make_my_trip/features/login/domain/usecases/user_google_login.dart';
import 'package:make_my_trip/features/login/domain/usecases/user_sign_in.dart';
import 'package:make_my_trip/utils/validators/user_info/user_information_validations.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
      {required this.facebookLogin,
      required this.signIn,
      required this.googleLogin,
      required this.forgetPassword})
      : super(LoginInitial());

  final UserGoogleLogin googleLogin;
  final UserSignIn signIn;
  final UserFacebookLogin facebookLogin;
  final UserForgetPassword forgetPassword;

  void changeObSecureEvent(bool obSecure) {
    emit(LoginObSecureChangeState(!obSecure));
  }

  signInWithGoogle() async {
    emit(AuthLoading());
    final res = await googleLogin.call(NoParams());
    res.fold((failure) {
      if (failure is AuthFailure) {
        emit(LoginErrorState(error: failure.failureMsg!));
      } else {
        emit(LoginErrorState(error: ""));
      }
    }, (success) {
      print(success.userEmail);
      emit(LoginSuccessState());
    });
  }

  signInWithEmail(String loginEmail, String loginPassword) async {
    emit(AuthLoading());
    final emailValidation =
        UserInfoValidation.emailAddressValidation(loginEmail);
    if (emailValidation != null) {
      emit(LoginErrorState(error: emailValidation));
    } else {
      final passwordValidation =
          UserInfoValidation.passwordValidation(loginPassword);
      if (passwordValidation != null) {
        emit(LoginErrorState(error: passwordValidation));
      } else {
        final res = await signIn.call(UserSignInParams(
            userEmail: loginEmail, userPassword: loginPassword));

        res.fold((failure) {
          if (failure is AuthFailure) {
            emit(LoginErrorState(error: failure.failureMsg!));
          }
        }, (success) {
          emit(LoginSuccessState());
        });
      }
    }
  }

  signInWithFacebook() async {
    final res = await facebookLogin.call(NoParams());
    res.fold((failure) {
      if (failure is AuthFailure) {
        emit(LoginErrorState(error: failure.failureMsg!));
      }
    }, (success) {
      emit(LoginSuccessState());
    });
  }

  userForgetPassword(String emailData) async {
    final emailValidation =
        UserInfoValidation.emailAddressValidation(emailData);
    if (emailValidation != null) {
      emit(LoginErrorState(error: emailValidation));
    } else {
      final res = await forgetPassword.call(UserForgetParam(email: emailData));
      res.fold((failure) {
        if (failure is AuthFailure) {
          emit(LoginErrorState(error: failure.failureMsg!));
        }
      }, (success) {
        emit(LoginSuccessState());
      });
    }
  }
}
