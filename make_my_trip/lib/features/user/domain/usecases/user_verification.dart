import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/user/domain/repositories/user_repository.dart';

class UserVerification {
  final UserRepository userRepository;

  UserVerification({required this.userRepository});

  Future<Either<Failures, bool>> call() async {
    return await userRepository.userVerification();
  }
}
