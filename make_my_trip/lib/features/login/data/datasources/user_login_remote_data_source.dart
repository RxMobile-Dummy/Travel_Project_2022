import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/failures/failures.dart';
import '../../domain/model/user_model.dart';

abstract class UserLoginRemoteDataSource {
  Future<Either<Failures, UserModel>> userSignIn(userEmail, userPassword);
  Future<Either<Failures, UserModel>> userGoogleLogIn();
  Future<Either<Failures, UserModel>> userFacebookLogIn();
}

class UserLoginRemoteDataSourceImpl extends UserLoginRemoteDataSource {
  final FirebaseAuth auth;
  UserLoginRemoteDataSourceImpl({
    required this.auth,
  });

  @override
  Future<Either<Failures, UserModel>> userSignIn(
      userEmail, userPassword) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: userPassword);
      User? user = userCredential.user;

      if (user != null) {
        return Right(UserModel.fromJson({
          "userName": user.displayName,
          "userEmail": user.email,
          "userPhone": user.phoneNumber,
          "userPic": user.photoURL,
          "userId": user.uid
        }));
      } else {
        return Left(ServerFailure());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left(AuthFailure(failureMsg: "Invalid Email"));
      } else if (e.code == 'wrong-password') {
        return Left(AuthFailure(failureMsg: "Invalid Password"));
      } else {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failures, UserModel>> userGoogleLogIn() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        return Right(UserModel.fromJson({
          "userName": user.displayName,
          "userEmail": user.email,
          "userPhone": user.phoneNumber,
          "userPic": user.photoURL,
          "userId": user.uid
        }));
      } else {
        return Left(ServerFailure());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return Left(AuthFailure(failureMsg: "Email is Already Registered"));
      } else {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failures, UserModel>> userFacebookLogIn() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      var userData = await FacebookAuth.instance.getUserData();
      UserCredential userCredential =
          await auth.signInWithCredential(facebookAuthCredential);

      User? user = userCredential.user;

      user!.updatePhotoURL(userData["picture"]["data"]["url"]);

      // ignore: unnecessary_null_comparison
      if (user != null) {
        return Right(UserModel.fromJson({
          "userName": user.displayName,
          "userEmail": user.email,
          "userPhone": user.phoneNumber,
          "userPic": user.photoURL,
          "userId": user.uid
        }));
      } else {
        return Left(ServerFailure());
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }
}
