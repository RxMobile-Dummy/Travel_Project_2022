import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failures, Type>> call(Params params);
}
