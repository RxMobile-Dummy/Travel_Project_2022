import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import '../repositories/sign_up_repository.dart';

class UserSignUp {
  final SignUpRepository repository;

  UserSignUp({required this.repository});

  Future<Either<Failures, bool>> call(
      String fullName, String email, String password) async {
    return await repository.userSignUp(fullName, email, password);
  }
}
