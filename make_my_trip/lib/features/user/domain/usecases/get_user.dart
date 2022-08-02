import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/user/data/model/user_model.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_repository.dart';

class GetUser extends Usecase<UserModel, NoParams> {
  final UserRepository repository;

  GetUser({required this.repository});

  @override
  Future<Either<Failures, UserModel>> call(NoParams params) async {
    return await repository.getUser();
  }
}
