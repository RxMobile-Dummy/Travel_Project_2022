// import 'dart:async';
//
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:make_my_trip/utils/constants/base_constants.dart';
// import 'package:make_my_trip/utils/constants/string_constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../core/failures/failures.dart';
//
// abstract class SignUpRemoteDataSource {
//   Future<Either<Failures, bool>> userSignUp(
//       {required String fullName,
//       required String email,
//       required String password});
//   Future<Either<Failures, bool>> userVerification();
// }
//
// class SignUpRemoteDataSourceImpl extends SignUpRemoteDataSource {
//   final FirebaseAuth auth;
//   final Dio dio;
//   final SharedPreferences sharedPreferences;
//   SignUpRemoteDataSourceImpl(
//       {required this.sharedPreferences, required this.dio, required this.auth});
//
//   Future<Options> createDioOptions() async {
//     final userToken = await auth.currentUser!.getIdToken();
//     return Options(headers: {'token': userToken});
//   }
//
//   @override
//   Future<Either<Failures, bool>> userSignUp(
//       {required String fullName,
//       required String email,
//       required String password}) async {
//     try {
//       UserCredential userCredential = await auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//
//       auth.fetchSignInMethodsForEmail(email);
//       User? user = userCredential.user;
//       user?.updateDisplayName(fullName);
//
//       if (user != null) {
//         final response = await dio.post('${BaseConstant.baseUrl}user',
//             options: await createDioOptions());
//         if (response.statusCode == 409) {
//           return Left(
//               AuthFailure(failureMsg: "Enter Email is Already Registred"));
//         } else {
//           if (response.statusCode == 200) {
//             sharedPreferences.setString(
//                 StringConstants.userIdSharedPreference, user.uid);
//             sharedPreferences.setBool(
//                 StringConstants.isAnonymousSharedPreference, false);
//             return Right(true);
//           } else {
//             return Left(ServerFailure());
//           }
//         }
//       } else {
//         return Left(ServerFailure());
//       }
//     } on FirebaseAuthException catch (err) {
//       if (err.code == 'email-already-in-use') {
//         return Left(
//             AuthFailure(failureMsg: "Enter Email is Already Registred"));
//       } else {
//         return Left(ServerFailure(failureMsg: "Somthing went Wrong"));
//       }
//     }
//   }
//
//   @override
//   Future<Either<Failures, bool>> userVerification() async {
//     try {
//       final User? currentUser = auth.currentUser;
//       currentUser!.sendEmailVerification();
//       bool result = false;
//
//       while (result != true) {
//         Future.delayed(const Duration(seconds: 5));
//         await currentUser.reload();
//         final User? verifiedUser = FirebaseAuth.instance.currentUser;
//         if (verifiedUser!.emailVerified) {
//           result = true;
//           break;
//         }
//       }
//       return Right(result);
//     } catch (err) {
//       return Left(ServerFailure(failureMsg: "Error in verification"));
//     }
//   }
// }
