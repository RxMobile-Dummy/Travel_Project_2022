import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/user/domain/repositories/user_repository.dart';

class UserSignOut extends Usecase<void, NoParams> {
  final UserRepository userRepository;

  UserSignOut({required this.userRepository});

  @override
  Future<Either<Failures, void>> call(NoParams params) async {
    return await userRepository.userSignOut();
  }
}
