import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';

abstract class IntroRepository {
  Future<Either<Failures, bool>> logInAnonymously();
}
