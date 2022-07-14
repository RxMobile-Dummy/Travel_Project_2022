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

  validate_Email(String email) {
    var resemail = UserInfoValidation.emailAddressValidation(email);
    if (resemail != null) {
      emit(SignUpError(resemail.toString()));
    } else {
      emit(SignUpError(""));
    }
  }

  validate_Name(String name) {
    var resname = UserInfoValidation.nameValidation(name);
    if (resname != null) {
      emit(SignUpError(resname));
    } else {
      emit(SignUpError(""));
    }
  }

  validate_Password(String password) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (!regex.hasMatch(password)) {
      emit(SignUpError("Please Enter a valid password"));
    } else {
      emit(SignUpError(""));
    }
  }

  waiting_dialog(progress_dialog) {
    progress_dialog = !progress_dialog;
    emit(WaitingDialog(waiting_dialog: progress_dialog));
  }

  create_User(
      {required String email,
      required String password,
      required String fullname,
      required String confirmpassword}) async {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (email.isEmpty) {
      var resemail = UserInfoValidation.emailAddressValidation(email);
      emit(SignUpError(resemail!));
    } else if (password.isEmpty || confirmpassword.isEmpty) {
      emit(SignUpError("Password and Confirm Password cant be empty!"));
    } else if (password != confirmpassword) {
      emit(SignUpError("Password and Confirm Password must be same!"));
    } else if (fullname.isEmpty) {
      var resname = UserInfoValidation.nameValidation(fullname);
      emit(SignUpError(resname!));
    } else if (!regex.hasMatch(password) || !regex.hasMatch(confirmpassword)) {
      emit(SignUpError("Please Enter valid password and confirm password"));
    } else {
      try {
        await registerusecase.call(Map(), email, password).then((value) =>
            value.fold(
                (l) => print("left"),
                (r) =>
                    Timer.periodic(const Duration(seconds: 5), (timer) async {
                      User? user = FirebaseAuth.instance.currentUser;
                      await user!.reload();
                      final myUser = FirebaseAuth.instance.currentUser;
                      if (myUser!.emailVerified) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('email',myUser.email.toString());
                        emit(RegisterSuccess(
                            success_message: 'Registered User Successfully!'));
                        timer.cancel();
                      }
                    })));
      } catch (e) {}
    }
  }
}
