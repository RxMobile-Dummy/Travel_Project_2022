import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import '../repositories/sign_up_repository.dart';

class UserVerification {
  final SignUpRepository repository;

  UserVerification({required this.repository});

  Future<Either<Failures, bool>> call() async {
    return await repository.userVerification();
  }
}
