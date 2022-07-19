import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/login/data/datasources/user_login_remote_data_source.dart';
import 'package:make_my_trip/features/login/domain/repositories/login_repository.dart';

import '../../../../core/failures/failures.dart';
import '../../domain/model/user_model.dart';

class UserLoginRepositoryImpl extends UserLoginRepository {
  final UserLoginRemoteDataSource remoteDataSource;

  UserLoginRepositoryImpl({required this.remoteDataSource});

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
  Future<Either<Failures, UserModel>> userFacebookLogin() async {
    return await remoteDataSource.userFacebookLogIn();
  }
}
