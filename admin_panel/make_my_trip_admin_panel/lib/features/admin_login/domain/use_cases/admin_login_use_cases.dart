import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/core/usecases/usecase.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/domain/repositories/admin_panel_repository.dart';

class AdminLoginUseCases extends UseCase<void, LoginParams> {
  final AdminLoginRepository adminLoginRepository;

  AdminLoginUseCases(this.adminLoginRepository);

  @override
  Future<Either<Failures, void>> call(LoginParams params) async {
    return await adminLoginRepository.adminLogin(
        email: params.email, password: params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
