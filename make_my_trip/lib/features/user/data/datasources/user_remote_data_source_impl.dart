import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/user/data/datasources/user_remote_data_source.dart';
import 'package:make_my_trip/features/user/data/model/user_model.dart';
import 'package:make_my_trip/features/user/domain/usecases/send_device_id.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;
  final Dio dio;
  final FirebaseMessaging firebaseMessaging;
  final SharedPreferences sharedPreferences;
  final FacebookAuth facebookAuth;
  UserRemoteDataSourceImpl(
      {required this.auth,
      required this.firebaseMessaging,
      required this.dio,
      required this.sharedPreferences,
      required this.googleSignIn,
      required this.facebookAuth});
  // user anonymous data_source methods impl
  @override
  Future<Either<Failures, bool>> isAnonumousUser() async {
    try {
      User? user = auth.currentUser;
      return Right(user!.isAnonymous);
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
      return Left(ServerFailure(failureMsg: StringConstants.someThingWent));
    }
  }

  @override
  Future<Either<Failures, UserModel>> userSignIn(
      userEmail, userPassword) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: userPassword);
      User? user = userCredential.user;
      if (user != null) {
        if (user.emailVerified) {
          return Right(UserModel.fromJson({
            "userName": user.displayName,
            "userEmail": user.email,
            "userPhone": user.phoneNumber,
            "userPic": user.photoURL,
            "userId": user.uid
          }));
        } else {
          auth.signOut();
          return Left(AuthFailure(failureMsg: "Email not varified"));
        }
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
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
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
              options: await BaseConstant.createDioOptions());
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
      final LoginResult loginResult = await facebookAuth.login();
      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);
        var userData = await facebookAuth.getUserData();
        UserCredential userCredential =
            await auth.signInWithCredential(facebookAuthCredential);
        User? user = userCredential.user;
        user!.updatePhotoURL(userData["picture"]["data"]["url"]);
        // ignore: unnecessary_null_comparison
        if (user != null) {
          final response = await dio.post('${BaseConstant.baseUrl}user/post',
              options: await BaseConstant.createDioOptions());
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

  @override
  Future<Either<Failures, void>> userSignOut() async {
    try {
      User? user = auth.currentUser;
      final List<String> response =
          await auth.fetchSignInMethodsForEmail(user!.email!);
      if (response[0] == "google.com") {
        await googleSignIn.signOut();
      } else if (response[0] == "facebook.com") {
        await facebookAuth.logOut();
      }
      await auth.signOut();
      await auth.signInAnonymously();
      return const Right(null);
    } on FirebaseException catch (e) {
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
      User? user = userCredential.user;
      await auth.currentUser!.updateDisplayName(fullName);
      user!.sendEmailVerification();
      if (user != null) {
        final response = await dio.post('${BaseConstant.baseUrl}user/post',
            options: await BaseConstant.createDioOptions());
        await userSignOut();
        if (response.statusCode == 409) {
          return Left(
              AuthFailure(failureMsg: "Enter Email is Already Registered"));
        } else {
          if (response.statusCode == 200) {
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
            AuthFailure(failureMsg: "Enter Email is Already Registered"));
      } else {
        return Left(ServerFailure(failureMsg: "Something went Wrong"));
      }
    }
  }

  @override
  Future<Either<Failures, bool>> userVerification() async {
    try {
      final User? currentUser = auth.currentUser;
      bool result = false;
      while (result != true) {
        Future.delayed(const Duration(seconds: 5));
        await currentUser!.reload();
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

  @override
  Future<Either<Failures, bool>> sendDeviceId() async {
    try {
      String? device;
      if (Platform.isAndroid) {
        device = "android";
      } else if (Platform.isIOS) {
        device = "ios";
      }

      final response = await dio.post('${BaseConstant.baseUrl}device',
          data: {
            "deviceid": await _getId(),
            "fcmtoken": await _getFcmToken(),
            "devicetype": device
          },
          options: await BaseConstant.createDioOptions());
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  _getId() async {
    // var deviceInfo = DeviceInfoPlugin();
    // if (Platform.isIOS) {
    //   var iosDeviceInfo = await deviceInfo.iosInfo;
    //   return iosDeviceInfo.identifierForVendor;
    // } else if (Platform.isAndroid) {
    //   var androidDeviceInfo = await deviceInfo.androidInfo;
    //   return androidDeviceInfo.id;
    // }
    String? token=await PlatformDeviceId.getDeviceId;
    return token;
  }

  _getFcmToken() async {
    String? token;
    token = await firebaseMessaging.getToken().then((value) => value);

    return token;
  }

  @override
  Future<Either<Failures, bool>> deleteDeviceId() async {
    try {
      final response = await dio.delete(
          '${BaseConstant.baseUrl}device/${await _getId()}',
          options: await BaseConstant.createDioOptions());
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, bool>> refreshFcmToken() async {
    try {
      final response = await dio.get('${BaseConstant.baseUrl}device/updatefcm',
          queryParameters: {
            "deviceid": await _getId(),
            "fcmtoken": await _getFcmToken(),
          },
          options: await BaseConstant.createDioOptions());
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, void>> deleteUserData() async {
    final response = await dio.get("${BaseConstant.baseUrl}user/deleteuser",
        options: await BaseConstant.createDioOptions());
    if (response.statusCode == 200) {
      return const Right(null);
    } else {
      return Left(ServerFailure());
    }
  }
}
