import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/user/domain/repositories/user_repository.dart';

class UserForgetPassword implements Usecase<void, UserForgetParam> {
  final UserRepository userRepository;

  UserForgetPassword({required this.userRepository});

  @override
  Future<Either<Failures, void>> call(UserForgetParam params) {
    return userRepository.userForgetPassword(params.email);
  }
}

class UserForgetParam extends Equatable {
  final String email;

  const UserForgetParam({required this.email});

  @override
  List<Object?> get props => [email];
}
