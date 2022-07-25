import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/login/data/datasources/user_login_remote_data_source.dart';
import 'package:make_my_trip/features/login/domain/repositories/login_repository.dart';

import '../../../../core/failures/failures.dart';
import '../../../login/domain/model/user_model.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, bool>> isAnonumousUser() async {
    return await remoteDataSource.isAnonumousUser();
  }

  @override
  Future<Either<Failures, UserModel>> getUser() async {
    return await remoteDataSource.getUser();
  }
}
