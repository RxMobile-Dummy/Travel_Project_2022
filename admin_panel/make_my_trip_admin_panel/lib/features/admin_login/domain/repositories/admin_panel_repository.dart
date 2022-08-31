import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';

abstract class AdminLoginRepository {
  Future<Either<Failures, void>> adminLogin({email, password});

  Future<Either<Failures, void>> validateAdmin();
}
