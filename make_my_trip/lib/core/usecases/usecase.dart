import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/core/failures/failures.dart';

/// use this abstract class for accessing by default properties from it
abstract class Usecase<Type, Params> {
  Future<Either<Failures, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
