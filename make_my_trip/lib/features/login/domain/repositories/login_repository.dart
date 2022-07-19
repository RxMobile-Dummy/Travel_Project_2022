import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/login/domain/model/user_model.dart';

abstract class UserLoginRepository {
  Future<Either<Failures, UserModel>> userSignIn({userEmail, userPassword});
  Future<Either<Failures, UserModel>> userGoogleLogin();
  Future<Either<Failures, UserModel>> userFacebookLogin();
  Future<Either<Failures, void>> userForgetPassword(String email);
}
