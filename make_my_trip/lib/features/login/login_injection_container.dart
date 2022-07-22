import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/login/data/datasources/user_login_remote_data_source.dart';
import 'package:make_my_trip/features/login/data/repositories/user_login_repository_impl.dart';
import 'package:make_my_trip/features/login/domain/repositories/login_repository.dart';
import 'package:make_my_trip/features/login/domain/usecases/user_facebook_login.dart';
import 'package:make_my_trip/features/login/domain/usecases/user_google_login.dart';
import 'package:make_my_trip/features/login/domain/usecases/user_sign_in.dart';
import 'package:make_my_trip/features/login/presentation/cubit/login_cubit.dart';

import 'domain/usecases/user_forget_password.dart';

final loginSl = GetIt.instance;

Future<void> init() async {
  loginSl.registerFactory(() => LoginCubit(
      signIn: loginSl(),
      googleLogin: loginSl(),
      facebookLogin: loginSl(),
      forgetPassword: loginSl()));

  //usecase
  loginSl.registerLazySingleton(() => UserGoogleLogin(repository: loginSl()));
  loginSl.registerLazySingleton(() => UserFacebookLogin(repository: loginSl()));
  loginSl.registerLazySingleton(() => UserSignIn(repository: loginSl()));
  loginSl
      .registerLazySingleton(() => UserForgetPassword(repository: loginSl()));

  //repository
  loginSl.registerLazySingleton<UserLoginRepository>(
      () => UserLoginRepositoryImpl(remoteDataSource: loginSl()));

  //datasources
  loginSl.registerLazySingleton<UserLoginRemoteDataSource>(
      () => UserLoginRemoteDataSourceImpl(auth: loginSl(), dio: loginSl()));

  //external
  loginSl.registerLazySingleton(() => FirebaseAuth.instance);
}
