import 'package:make_my_trip/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/intro/data/datasources/intro_remote_data_sources.dart';
import 'package:make_my_trip/features/intro/domain/repositories/intro_repository.dart';

class IntroRepositoryImpl extends IntroRepository {
  final IntroRemoteDataSource remoteDataSource;
  IntroRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, bool>> logInAnonymously() async {
    return await remoteDataSource.logInAnonymously();
  }
}
