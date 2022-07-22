import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/failures/failures.dart';

abstract class SignUpRemoteDataSource {
  Future<Either<Failures, bool>> userSignUp(
      {required String fullName,
      required String email,
      required String password});
  Future<Either<Failures, bool>> userVerification();
}

class SignUpRemoteDataSourceImpl extends SignUpRemoteDataSource {
  final FirebaseAuth auth;

  SignUpRemoteDataSourceImpl({required this.auth});

  @override
  Future<Either<Failures, bool>> userSignUp(
      {required String fullName,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      auth.fetchSignInMethodsForEmail(email);
      User? user = userCredential.user;
      user?.updateDisplayName(fullName);
      return const Right(true);
    } on FirebaseAuthException catch (err) {
      if (err.code == 'email-already-in-use') {
        return Left(
            AuthFailure(failureMsg: "Enter Email is Already Registred"));
      } else {
        return Left(ServerFailure(failureMsg: "Somthing went Wrong"));
      }
    }
  }

  @override
  Future<Either<Failures, bool>> userVerification() async {
    try {
      final User? currentUser = auth.currentUser;
      currentUser!.sendEmailVerification();
      bool result = false;

      while (result != true) {
        Future.delayed(const Duration(seconds: 5));
        await currentUser.reload();
        final User? verifiedUser = FirebaseAuth.instance.currentUser;
        if (verifiedUser!.emailVerified) {
          result = true;
          break;
        }
      }
      return Right(result);
    } catch (err) {
      return Left(ServerFailure(failureMsg: "Error in verification"));
    }
  }
}
