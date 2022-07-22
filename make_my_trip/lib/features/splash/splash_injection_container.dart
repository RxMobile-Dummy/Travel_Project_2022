import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/sign_up/data/data_sources/sign_up_remote_datasource_impl.dart';
import 'package:make_my_trip/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:make_my_trip/features/sign_up/domain/usecases/user_sign_up.dart';
import 'package:make_my_trip/features/sign_up/domain/usecases/user_verification.dart';
import 'package:make_my_trip/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:make_my_trip/features/splash/data/datasources/splash_remote_data_sources.dart';
import 'package:make_my_trip/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:make_my_trip/features/splash/domain/repositories/splash_repository.dart';
import 'package:make_my_trip/features/splash/domain/usecases/logIn_anonymously.dart';
import 'package:make_my_trip/features/splash/presentation/cubit/splash_cubit.dart';

final splashSl = GetIt.instance;

Future<void> init() async {
  splashSl.registerFactory(() => SplashCubit(logInAnonymously: splashSl()));

  //usecase
  splashSl
      .registerLazySingleton(() => LogInAnonymously(repository: splashSl()));
  //repository
  splashSl.registerLazySingleton<SplashRepository>(
      () => SplashRepositoryImpl(remoteDataSource: splashSl()));

  //datasources
  splashSl.registerLazySingleton<SplashRemoteDataSource>(
      () => SplashRemoteDataSourceImpl(auth: splashSl()));
}
