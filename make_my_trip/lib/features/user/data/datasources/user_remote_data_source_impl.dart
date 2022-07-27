import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/user/data/datasources/user_remote_data_source.dart';
import 'package:make_my_trip/features/user/data/model/user_model.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final FirebaseAuth auth;
  final Dio dio;
  final SharedPreferences sharedPreferences;

  UserRemoteDataSourceImpl(
      {required this.auth, required this.dio, required this.sharedPreferences});

  // user anonymous data_source methods impl
  @override
  Future<Either<Failures, bool>> isAnonumousUser() async {
    try {
      User? user = auth.currentUser;
      if (user?.email != null) {
        return const Right(false);
      } else {
        return const Right(true);
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, UserModel>> getUser() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        return Right(UserModel(
            userName: user.displayName,
            userEmail: user.email,
            userPhone: user.phoneNumber,
            userPic: user.photoURL,
            userId: user.uid));
      } else {
        return Right(UserModel.fromJson(const {}));
      }
    } catch (err) {
      return Left(ServerFailure(failureMsg: "Something went wrong"));
    }
  }

  // login data_source methods impl
  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
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

      if (googleUser != null) {
        final GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;

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
    } on FirebaseAuthException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, void>> userForgetPasswordData(emailAddress) async {
    try {
      final forget = await auth.sendPasswordResetEmail(email: emailAddress);
      return Right(forget);
    } on FirebaseAuthException {
      return Left(ServerFailure());
    }
  }

  // sign_up data_source methods impl
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

      if (user != null) {
        final response = await dio.post('${BaseConstant.baseUrl}user',
            options: await createDioOptions());
        if (response.statusCode == 409) {
          return Left(
              AuthFailure(failureMsg: "Enter Email is Already Registred"));
        } else {
          if (response.statusCode == 200) {
            sharedPreferences.setString(
                StringConstants.userIdSharedPreference, user.uid);
            sharedPreferences.setBool(
                StringConstants.isAnonymousSharedPreference, false);
            return const Right(true);
          } else {
            return Left(ServerFailure());
          }
        }
      } else {
        return Left(ServerFailure());
      }
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
