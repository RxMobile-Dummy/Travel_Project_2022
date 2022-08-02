import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/user/data/model/user_model.dart';
import 'package:make_my_trip/features/user/domain/repositories/user_repository.dart';

class UserFacebookLogin extends Usecase<UserModel, NoParams> {
  final UserRepository userRepository;

  UserFacebookLogin({required this.userRepository});

  @override
  Future<Either<Failures, UserModel>> call(NoParams params) async {
    return await userRepository.userFacebookLogin();
  }
}
