import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/login/domain/repositories/login_repository.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../model/user_model.dart';

class UserGoogleLogin extends Usecase<UserModel, NoParams> {
  final UserLoginRepository repository;

  UserGoogleLogin({required this.repository});

  @override
  Future<Either<Failures, UserModel>> call(NoParams params) async {
    return await repository.userGoogleLogin();
  }
}
