import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/core/usecases/usecase.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/domain/repositories/admin_panel_repository.dart';

class LogOutUseCases extends UseCase<void, NoParams> {
  final AdminLoginRepository adminLoginRepository;

  LogOutUseCases(this.adminLoginRepository);

  @override
  Future<Either<Failures, void>> call(params) async {
    return await adminLoginRepository.validateAdmin();
  }
}
