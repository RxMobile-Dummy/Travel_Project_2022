import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/user/data/model/user_model.dart';

abstract class UserRemoteDataSource {
  //user anonymous data_source methods
  Future<Either<Failures, bool>> isAnonumousUser();

  Future<Either<Failures, UserModel>> getUser();

  //login data_source methods
  Future<Either<Failures, UserModel>> userSignIn(userEmail, userPassword);

  Future<Either<Failures, UserModel>> userGoogleLogIn();

  Future<Either<Failures, UserModel>> userFacebookLogIn();

  Future<Either<Failures, void>> userForgetPasswordData(String emailAddress);

  Future<Either<Failures, void>> userSignOut();

  Future<Either<Failures, void>> deleteUserData();

//sign_up data_source methods
  Future<Either<Failures, bool>> userSignUp(
      {required String fullName,
      required String email,
      required String password});

  Future<Either<Failures, bool>> userVerification();
}
