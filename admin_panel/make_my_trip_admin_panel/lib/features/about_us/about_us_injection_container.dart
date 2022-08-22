import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip_admin_panel/features/about_us/presentation/cubit/about_us_cubit.dart';

import 'data/data_sources/about_us_remote_data_sources.dart';
import 'data/repositories/about_us_repository_impl.dart';
import 'domain/repositories/about_us_repository.dart';
import 'domain/use_cases/about_us_update_usecase.dart';
import 'domain/use_cases/about_us_usecase.dart';

final slAboutUsPage = GetIt.instance;

Future<void> init() async {
  slAboutUsPage.registerLazySingleton(() => FirebaseFirestore.instance);

  //cubit
  slAboutUsPage
      .registerFactory(() => AboutUsCubit(slAboutUsPage(), slAboutUsPage()));

  //Usecase
  slAboutUsPage.registerLazySingleton(() => AboutUsUseCase(slAboutUsPage()));
  slAboutUsPage
      .registerLazySingleton(() => AboutUsUpdateUseCase(slAboutUsPage()));

  //Repository
  slAboutUsPage.registerLazySingleton<AboutUsRepository>(
      () => AboutUsRepositoryImpl(slAboutUsPage()));

  //Data source
  slAboutUsPage.registerLazySingleton<AboutUsRemoteDataSources>(
      () => AboutUsRemoteDataSourcesImpl(slAboutUsPage()));
}
