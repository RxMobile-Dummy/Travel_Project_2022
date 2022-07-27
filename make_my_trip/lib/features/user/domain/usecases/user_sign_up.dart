import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/user/domain/repositories/user_repository.dart';

class UserSignUp {
  final UserRepository userRepository;

  UserSignUp({required this.userRepository});

  Future<Either<Failures, bool>> call(
      String fullName, String email, String password) async {
    return await userRepository.userSignUp(fullName, email, password);
  }
}
