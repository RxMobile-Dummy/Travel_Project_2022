import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../failures/failures.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failures, Type>> call(Params params);
}
