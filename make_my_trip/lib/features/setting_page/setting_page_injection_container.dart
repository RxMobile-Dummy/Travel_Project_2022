import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/setting_page/data/data_sources/user_details_remote_data_source_impl.dart';
import 'package:make_my_trip/features/setting_page/data/data_sources/user_local_data_source.dart';
import 'package:make_my_trip/features/setting_page/data/data_sources/user_local_data_source_impl.dart';
import 'package:make_my_trip/features/setting_page/data/repositories/setting_page_repository_impl.dart';
import 'package:make_my_trip/features/setting_page/domain/repositories/setting_page_repository.dart';
import 'package:make_my_trip/features/setting_page/domain/use_cases/get_user_data_usecase.dart';
import 'package:make_my_trip/features/setting_page/domain/use_cases/update_image_usecase.dart';
import 'package:make_my_trip/features/setting_page/domain/use_cases/update_user_data_usecase.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/setting_page_cubit.dart';
import 'data/data_sources/user_details_remote_data_source.dart';

final slSettingPage = GetIt.instance;

Future<void> init() async {
  //cubit
  slSettingPage.registerFactory(() =>
      SettingPageCubit(slSettingPage(), slSettingPage(), slSettingPage()));

  //Data source
  slSettingPage.registerLazySingleton<UserDetailsRemoteDataSource>(
      () => UserDetailsRemoteDataSourceimpl(slSettingPage()));

  slSettingPage.registerLazySingleton<UserDetailsLocalDataSource>(
      () => UserDetailsLocalDataSourceimpl());

  //Repository
  slSettingPage.registerLazySingleton<Settingpagerepository>(
      () => Settingpagerepositoryimpl(slSettingPage(), slSettingPage()));

  //Usecase
  slSettingPage
      .registerLazySingleton(() => GetUserDataUseCase(slSettingPage()));

  slSettingPage
      .registerLazySingleton(() => UpdateImageUseCase(slSettingPage()));

  slSettingPage
      .registerLazySingleton(() => UpdateUserDataUseCase(slSettingPage()));
}
