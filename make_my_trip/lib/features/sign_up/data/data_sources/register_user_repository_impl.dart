import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/failures/failures.dart';
import 'register_user_datasource.dart';

class Register_User_Datasource_Impl extends Register_User_Datasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Either<Failures, dynamic>> register_user(
      {required String email, required String password}) async {
    try {
      User user;
      await _auth.createUserWithEmailAndPassword(
          email: email.toString().trim(), password: password.toString().trim());

      user = _auth.currentUser!;
      await user.sendEmailVerification();
      return Right("true");
    }
    catch(e){
    return Left(AuthFailure(failureMsg: e.toString()));
    }
  }
}
