import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/user/data/model/user_model.dart';
import 'package:make_my_trip/features/user/domain/repositories/user_repository.dart';

class UserSignIn extends Usecase<UserModel, UserSignInParams> {
  final UserRepository userRepository;

  UserSignIn({required this.userRepository});

  @override
  Future<Either<Failures, UserModel>> call(UserSignInParams params) async {
    return await userRepository.userSignIn(
        userEmail: params.userEmail, userPassword: params.userPassword);
  }
}

class UserSignInParams extends Equatable {
  final String userEmail;
  final String userPassword;

  const UserSignInParams({required this.userEmail, required this.userPassword});

  @override
  List<Object?> get props => [userEmail, userPassword];
}
