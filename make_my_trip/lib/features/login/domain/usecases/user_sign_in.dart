import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/features/login/domain/repositories/login_repository.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../model/user_model.dart';

class UserSignIn extends Usecase<UserModel, UserSignInParams> {
  final UserLoginRepository repository;

  UserSignIn({required this.repository});

  @override
  Future<Either<Failures, UserModel>> call(UserSignInParams params) async {
    return await repository.userSignIn(
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
