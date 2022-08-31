import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/data/data_sources/admin_login_data_source.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/domain/repositories/admin_panel_repository.dart';

class AdminLoginRepositoryImpl implements AdminLoginRepository {
  final AdminLoginDataSource adminLoginDataSource;

  AdminLoginRepositoryImpl(this.adminLoginDataSource);

  @override
  Future<Either<Failures, void>> adminLogin({email, password}) async {
    return await adminLoginDataSource.adminLogin(email, password);
  }

  @override
  Future<Either<Failures, void>> validateAdmin() async {
    return await adminLoginDataSource.validateAdmin();
  }
}
