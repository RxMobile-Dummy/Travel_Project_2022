import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import '../model/user_model.dart';
import '../repositories/login_repository.dart';

class UserForgetPassword implements Usecase<void, UserForgetParam> {
  final UserLoginRepository repository;
  UserForgetPassword({required this.repository});

  @override
  Future<Either<Failures, void>> call(UserForgetParam params) {
    return repository.userForgetPassword(params.email);
  }
}

class UserForgetParam extends Equatable {
  final String email;
  const UserForgetParam({required this.email});

  @override
  List<Object?> get props => [email];
}
