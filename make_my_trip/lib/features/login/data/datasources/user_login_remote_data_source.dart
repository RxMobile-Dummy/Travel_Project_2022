import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:make_my_trip/features/login/domain/usecases/user_facebook_login.dart';

import '../../../../core/failures/failures.dart';
import '../../../../utils/constants/base_constants.dart';
import '../../domain/model/user_model.dart';

abstract class UserLoginRemoteDataSource {
  Future<Either<Failures, UserModel>> userSignIn(userEmail, userPassword);
  Future<Either<Failures, UserModel>> userGoogleLogIn();
  Future<Either<Failures, UserModel>> userFacebookLogIn();
  Future<Either<Failures, void>> userForgetPasswordData(String emailAddress);
}

class UserLoginRemoteDataSourceImpl extends UserLoginRemoteDataSource {
  final FirebaseAuth auth;
  final Dio dio;

  UserLoginRemoteDataSourceImpl({
    required this.dio,
    required this.auth,
  });
  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
  Future<Options> createDioOptions() async {
    final userToken = await auth.currentUser!.getIdToken();
    printWrapped(userToken);
    return Options(headers: {'token': userToken});
  }

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
        final response = await dio.post('${BaseConstant.baseUrl}user/post',
            options: await createDioOptions());
        if (response.statusCode == 200 || response.statusCode == 409) {
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

      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        var userData = await FacebookAuth.instance.getUserData();
        UserCredential userCredential =
            await auth.signInWithCredential(facebookAuthCredential);

        User? user = userCredential.user;

        user!.updatePhotoURL(userData["picture"]["data"]["url"]);

        // ignore: unnecessary_null_comparison
        if (user != null) {
          final response = await dio.post('${BaseConstant.baseUrl}user/post',
              options: await createDioOptions());
          if (response.statusCode == 200 || response.statusCode == 409) {
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
        } else {
          return Left(ServerFailure());
        }
      } else {
        return Left(ServerFailure());
      }
    } on FirebaseAuthException catch (e) {

      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, void>> userForgetPasswordData(emailAddress) async {
    try {
      final forget = await auth.sendPasswordResetEmail(email: emailAddress);
      return Right(forget);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure());
    }
  }
}
