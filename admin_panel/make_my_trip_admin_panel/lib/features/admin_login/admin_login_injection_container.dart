import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/data/data_sources/admin_login_data_source.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/data/data_sources/admin_login_data_source_impl.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/data/repositories/admin_panel_repository_impl.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/domain/repositories/admin_panel_repository.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/domain/use_cases/admin_login_use_cases.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/domain/use_cases/validate_admin_use_cases.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/presentation/cubit/admin_login_cubit.dart';

final slAdminLogin = GetIt.instance;

Future<void> init() async {
  //cubit
  slAdminLogin
      .registerFactory(() => AdminLoginCubit(slAdminLogin(), slAdminLogin()));

  //Data source
  slAdminLogin.registerLazySingleton<AdminLoginDataSource>(
      () => AdminLoginDataSourceImpl(slAdminLogin(), slAdminLogin()));

  //Repository
  slAdminLogin.registerLazySingleton<AdminLoginRepository>(
      () => AdminLoginRepositoryImpl(slAdminLogin()));

  //Usecase
  slAdminLogin.registerLazySingleton(() => AdminLoginUseCases(slAdminLogin()));
  slAdminLogin
      .registerLazySingleton(() => AdminValidationUseCases(slAdminLogin()));

  //firebase
  slAdminLogin.registerLazySingleton(() => FirebaseAuth.instance);

  //dio
  slAdminLogin.registerLazySingleton(() => Dio());
}
