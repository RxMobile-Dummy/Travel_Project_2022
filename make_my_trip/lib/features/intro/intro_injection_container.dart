import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/intro/presentation/cubit/intro_cubit.dart';
import 'package:make_my_trip/features/intro/data/datasources/intro_remote_data_sources.dart';
import 'package:make_my_trip/features/intro/data/repositories/intro_repository_impl.dart';
import 'package:make_my_trip/features/intro/domain/repositories/intro_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/usecases/logIn_anonymously.dart';

final IntroSl = GetIt.instance;

Future<void> init() async {
  IntroSl.registerFactory(() => IntroCubit(logInAnonymously: IntroSl()));
  //usecase
  IntroSl.registerLazySingleton(() => LogInAnonymously(repository: IntroSl()));
  //repository
  IntroSl.registerLazySingleton<IntroRepository>(
      () => IntroRepositoryImpl(remoteDataSource: IntroSl()));
  //datasources
  IntroSl.registerLazySingleton<IntroRemoteDataSource>(() =>
      IntroRemoteDataSourceImpl(auth: IntroSl(), sharedPreferences: IntroSl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  IntroSl.registerLazySingleton(() => sharedPreferences);
}
