import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/features/sign_up/domain/use_cases/register_user_usecase.dart';
import 'package:make_my_trip/utils/validators/user_info/user_information_validations.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.registerusecase}) : super(SignUpInitial());
  final Register_User_Usecase registerusecase;

  // validate_Email(String email) {
  //   var resemail = UserInfoValidation.emailAddressValidation(email);
  //   if (resemail != null) {
  //     emit(SignUpError(resemail.toString()));
  //   } else {
  //     emit(SignUpError(""));
  //   }
  // }

  // validate_Name(String name) {
  //   var resname = UserInfoValidation.nameValidation(name);
  //   if (resname != null) {
  //     emit(SignUpError(resname));
  //   } else {
  //     emit(SignUpError(""));
  //   }
  // }

  // validate_Password(String password) {
  //   RegExp regex =
  //       RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  //   if (!regex.hasMatch(password)) {
  //     emit(SignUpError("Please Enter a valid password"));
  //   } else {
  //     emit(SignUpError(""));
  //   }
  // }

  waiting_dialog(progress_dialog) {
    progress_dialog = !progress_dialog;
    emit(WaitingDialog(waiting_dialog: progress_dialog));
  }

  signUpWithEmail(
      {required String signUpEmail,
      required String signUpPassword,
      required String signUpFullname,
      required String signUpConfirmPassword}) async {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (signUpEmail.isEmpty) {
      var resemail = UserInfoValidation.emailAddressValidation(signUpEmail);
      emit(SignUpError(resemail!));
    } else if (signUpPassword.isEmpty || signUpConfirmPassword.isEmpty) {
      emit(SignUpError("Password and Confirm Password cant be empty!"));
    } else if (signUpPassword != signUpConfirmPassword) {
      emit(SignUpError("Password and Confirm Password must be same!"));
    } else if (signUpFullname.isEmpty) {
      var resname = UserInfoValidation.nameValidation(signUpFullname);
      emit(SignUpError(resname!));
    } else if (!regex.hasMatch(signUpPassword) ||
        !regex.hasMatch(signUpConfirmPassword)) {
      emit(SignUpError("Please Enter valid password and confirm password"));
    } else {
      try {
        await registerusecase.call(Map(), signUpEmail, signUpPassword).then(
            (value) => value.fold(
                (l) => print("left"),
                (r) =>
                    Timer.periodic(const Duration(seconds: 5), (timer) async {
                      User? user = FirebaseAuth.instance.currentUser;
                      await user!.reload();
                      final myUser = FirebaseAuth.instance.currentUser;
                      if (myUser!.emailVerified) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('email', myUser.email.toString());
                        emit(RegisterSuccess(
                            success_message: 'Registered User Successfully!'));
                        timer.cancel();
                      }
                    })));
      } catch (e) {}
    }
  }
}
