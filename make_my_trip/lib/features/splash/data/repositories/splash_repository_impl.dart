import 'package:make_my_trip/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/splash/data/datasources/splash_remote_data_sources.dart';
import 'package:make_my_trip/features/splash/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl extends SplashRepository {
  final SplashRemoteDataSource remoteDataSource;
  SplashRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, bool>> logInAnonymously() async {
    return await remoteDataSource.logInAnonymously();
  }
}
