import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../login/domain/model/user_model.dart';
import '../repositories/user_repository.dart';

class GetUser extends Usecase<UserModel, NoParams> {
  final UserRepository repository;

  GetUser({required this.repository});

  @override
  Future<Either<Failures, UserModel>> call(NoParams params) async {
    return await repository.getUser();
  }
}
