import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failures, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
