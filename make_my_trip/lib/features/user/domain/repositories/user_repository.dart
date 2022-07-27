import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/user/data/model/user_model.dart';

abstract class UserRepository {
  //user anonymous repository methods
  Future<Either<Failures, bool>> isAnonumousUser();

  Future<Either<Failures, UserModel>> getUser();

  //login repository methods
  Future<Either<Failures, UserModel>> userSignIn({userEmail, userPassword});

  Future<Either<Failures, UserModel>> userGoogleLogin();

  Future<Either<Failures, UserModel>> userFacebookLogin();

  Future<Either<Failures, void>> userForgetPassword(String email);

  //sign_up repository methods
  Future<Either<Failures, bool>> userSignUp(
      String fullName, String email, String password);

  Future<Either<Failures, bool>> userVerification();
}
