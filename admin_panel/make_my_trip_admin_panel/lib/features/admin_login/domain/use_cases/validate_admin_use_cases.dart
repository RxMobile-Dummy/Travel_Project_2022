import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/core/usecases/usecase.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/domain/repositories/admin_panel_repository.dart';

class AdminValidationUseCases extends UseCase<void, NoParams> {
  final AdminLoginRepository adminLoginRepository;

  AdminValidationUseCases(this.adminLoginRepository);

  @override
  Future<Either<Failures, void>> call(params) async {
    return await adminLoginRepository.validateAdmin();
  }
}
