import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:localstorage/localstorage.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/data/data_sources/admin_login_data_source.dart';
import 'package:make_my_trip_admin_panel/utils/constants/base_constants.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

class AdminLoginDataSourceImpl implements AdminLoginDataSource {
  final LocalStorage storage = LocalStorage('userCredential');
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
      await dio.get('${BaseConstant.baseUrl}user/admincheck',
          options: await BaseConstant.createDioOptions());
      storage.setItem('email', auth.currentUser!.email);
      return const Right(null);
    } on DioError catch (err) {
      if (err.response!.statusCode == 401) {
        auth.signOut();
        return left(AuthFailure(failureMsg: err.response.toString()));
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, void>> logOut() async {
    try {
      await auth.signOut();
      storage.deleteItem('email');
      return const Right(null);
    } on FirebaseException {
      return Left(ServerFailure());
    }
  }
}
