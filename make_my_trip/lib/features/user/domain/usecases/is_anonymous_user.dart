import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../login/domain/model/user_model.dart';
import '../repositories/user_repository.dart';

class IsAnonymousUser extends Usecase<bool, NoParams> {
  final UserRepository repository;

  IsAnonymousUser({required this.repository});

  @override
  Future<Either<Failures, bool>> call(NoParams params) async {
    return await repository.isAnonumousUser();
  }
}
