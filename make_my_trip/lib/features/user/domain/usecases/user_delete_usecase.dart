import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/user/domain/repositories/user_repository.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';

class DeleteUserUseCase implements Usecase<void, NoParams> {
  final UserRepository userRepository;
  DeleteUserUseCase(this.userRepository);

  @override
  Future<Either<Failures, void>> call(NoParams params) async {
    return await userRepository.deleteUser();
  }
}
