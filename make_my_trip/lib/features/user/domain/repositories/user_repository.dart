import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/login/domain/model/user_model.dart';

abstract class UserRepository {
  Future<Either<Failures, bool>> isAnonumousUser();
}
