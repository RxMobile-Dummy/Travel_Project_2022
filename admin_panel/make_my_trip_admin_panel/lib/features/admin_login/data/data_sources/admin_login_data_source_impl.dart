import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/data/data_sources/admin_login_data_source.dart';
import 'package:make_my_trip_admin_panel/utils/constants/base_constants.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

class AdminLoginDataSourceImpl implements AdminLoginDataSource {
  final FirebaseAuth auth;
  final Dio dio;

  AdminLoginDataSourceImpl(this.auth, this.dio);

  Future<Options> createDioOptions() async {
    final userToken = await auth.currentUser!.getIdToken(true);
    printWrapped(userToken);
    return Options(headers: {'token': userToken});
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

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
          options: await createDioOptions());
      if (response.statusCode == 200) {
        return const Right(null);
      }
      if (response.statusCode == 401) {
        return left(AuthFailure(failureMsg: response.statusMessage));
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
