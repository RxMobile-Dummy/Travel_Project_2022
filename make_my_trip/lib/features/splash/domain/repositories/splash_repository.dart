import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';

abstract class SplashRepository {
  Future<Either<Failures, bool>> logInAnonymously();
}
