import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/login/data/datasources/user_login_remote_data_source.dart';
import 'package:make_my_trip/features/login/data/repositories/user_login_repository_impl.dart';
import 'package:make_my_trip/features/login/domain/repositories/login_repository.dart';
import 'package:make_my_trip/features/login/domain/usecases/user_facebook_login.dart';
import 'package:make_my_trip/features/login/domain/usecases/user_google_login.dart';
import 'package:make_my_trip/features/login/domain/usecases/user_sign_in.dart';
import 'package:make_my_trip/features/login/presentation/cubit/login_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  login();
}

login() {
  //bloc or cubit
  sl.registerFactory(() => LoginCubit(signIn: sl(), googleLogin: sl()));

  //usecase
  sl.registerLazySingleton(() => UserGoogleLogin(repository: sl()));
  sl.registerLazySingleton(() => UserFacebookLogin(repository: sl()));
  sl.registerLazySingleton(() => UserSignIn(repository: sl()));

  //repository
  sl.registerLazySingleton<UserLoginRepository>(
      () => UserLoginRepositoryImpl(remoteDataSource: sl()));

  //datasources
  sl.registerLazySingleton<UserLoginRemoteDataSource>(
      () => UserLoginRemoteDataSourceImpl(auth: sl()));

  //external
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}
