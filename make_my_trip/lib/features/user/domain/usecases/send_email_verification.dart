import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_repository.dart';

class SendMailVerification {
  final UserRepository repository;

  SendMailVerification({required this.repository});

  Future<Either<Failures, bool>> call() async {
    return await repository.sendEmailVerification();
  }
}
