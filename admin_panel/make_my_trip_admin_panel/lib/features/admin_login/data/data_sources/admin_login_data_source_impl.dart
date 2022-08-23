import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/data/data_sources/admin_login_data_source.dart';
import 'package:make_my_trip_admin_panel/utils/constants/base_constants.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

class AdminLoginDataSourceImpl implements AdminLoginDataSource {
  final FirebaseAuth auth;
  final Dio dio;

  AdminLoginDataSourceImpl(this.auth, this.dio);

  @override
  Future<Either<Failures, void>> adminLogin(email, password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        return const Right(null);
      } else {
        return Left(ServerFailure());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == StringConstants.firebaseEmailError) {
        return Left(AuthFailure(
            failureMsg: StringConstants.firebaseInvalidEmailMessage));
      } else if (e.code == StringConstants.firebasePassError) {
        return Left(AuthFailure(
            failureMsg: StringConstants.firebaseInvalidPassMessage));
      } else {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failures, void>> validateAdmin() async {
    try {

      final response = await dio.get('${BaseConstant.baseUrl}user/admincheck',
          options: await BaseConstant.createDioOptions());
      if(response.statusCode==200){
        await auth.signOut();
        await auth.signInWithCustomToken(response.data["token"]);
        return const Right(null);
      }else{
        return Left(ServerFailure());
      }
    } on DioError catch (err) {
      debugPrint(err.toString());
      if (err.response!.statusCode == 401) {
        return left(AuthFailure(failureMsg: err.response.toString()));
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      debugPrint(err.toString());
      return Left(ServerFailure());
    }
  }
}
