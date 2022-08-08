import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/user/data/model/user_model.dart';
import '../../../../core/failures/failures.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  //user anonymous repository methods impl
  @override
  Future<Either<Failures, bool>> isAnonumousUser() async {
    return await remoteDataSource.isAnonumousUser();
  }

  @override
  Future<Either<Failures, UserModel>> getUser() async {
    return await remoteDataSource.getUser();
  }

  // login repository methods impl
  @override
  Future<Either<Failures, UserModel>> userSignIn(
      {userEmail, userPassword}) async {
    return await remoteDataSource.userSignIn(userEmail, userPassword);
  }

  @override
  Future<Either<Failures, UserModel>> userGoogleLogin() async {
    return await remoteDataSource.userGoogleLogIn();
  }

  @override
  Future<Either<Failures, void>> userSignOut() async{
    return await remoteDataSource.userSignOut();
  }

  // sign_up repository methods impl
  @override
  Future<Either<Failures, UserModel>> userFacebookLogin() async {
    return await remoteDataSource.userFacebookLogIn();
  }

  @override
  Future<Either<Failures, void>> userForgetPassword(String email) async {
    return await remoteDataSource.userForgetPasswordData(email);
  }

  @override
  Future<Either<Failures, bool>> userSignUp(
      String fullName, String email, String password) async {
    return await remoteDataSource.userSignUp(
        fullName: fullName,
        email: email.toString(),
        password: password.toString());
  }

  @override
  Future<Either<Failures, bool>> userVerification() async {
    print("user repository");
    print(await remoteDataSource.userVerification());
    return await remoteDataSource.userVerification();
  }
}
