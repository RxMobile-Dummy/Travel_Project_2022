import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_facebook_login.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_forget_password.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_google_login.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_sign_in.dart';
import 'package:make_my_trip/utils/validators/user_info/user_information_validations.dart';

part 'user_state.dart';

class UserCubit extends Cubit<BaseState> {
  UserCubit(
      {required this.googleLogin,
      required this.signIn,
      required this.facebookLogin,
      required this.forgetPassword})
      : super(StateInitial());
  final UserGoogleLogin googleLogin;
  final UserSignIn signIn;
  final UserFacebookLogin facebookLogin;
  final UserForgetPassword forgetPassword;

  void changeObSecureEvent(bool obSecure) {
    emit(StateOnKnownToSuccess(!obSecure));
  }

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
      print(success.userEmail);
      emit(StateOnSuccess("success"));
    });
  }

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
}
