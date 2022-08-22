import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:make_my_trip/features/user/data/datasources/user_remote_data_source_impl.dart';
import 'package:make_my_trip/features/user/domain/usecases/delete_device_id.dart';
import 'package:make_my_trip/features/user/domain/usecases/get_user.dart';
import 'package:make_my_trip/features/user/domain/usecases/is_anonymous_user.dart';
import 'package:make_my_trip/features/user/domain/usecases/refresh_fcm_token.dart';
import 'package:make_my_trip/features/user/domain/usecases/send_device_id.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_facebook_login.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_forget_password.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_google_login.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_sign_in.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_sign_out.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_sign_up.dart';
import 'package:make_my_trip/features/user/domain/usecases/user_verification.dart';
import 'package:make_my_trip/features/user/presentation/cubit/user_cubit.dart';
import 'data/datasources/user_remote_data_source.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecases/user_delete_usecase.dart';

final userSl = GetIt.instance;

Future<void> init() async {
  userSl.registerFactory(() => UserCubit(
        sendDeviceId: userSl(),
        signIn: userSl(),
        forgetPassword: userSl(),
        googleLogin: userSl(),
        facebookLogin: userSl(),
        userVerification: userSl(),
        userSignUp: userSl(),
        userSignOut: userSl(),
        deleteDeviceId: userSl(),
        deleteUserUseCase: userSl(),
      ));

  //user anonymous use_cases
  userSl.registerLazySingleton(() => IsAnonymousUser(repository: userSl()));
  userSl.registerLazySingleton(() => GetUser(repository: userSl()));
  userSl.registerLazySingleton(() => SendDeviceId(repository: userSl()));
  userSl.registerLazySingleton(() => RefreshFcmToken(repository: userSl()));
  userSl.registerLazySingleton(() => DeleteDeviceId(repository: userSl()));

  //login use_cases
  userSl.registerLazySingleton(() => UserGoogleLogin(userRepository: userSl()));
  userSl
      .registerLazySingleton(() => UserFacebookLogin(userRepository: userSl()));
  userSl.registerLazySingleton(() => UserSignIn(userRepository: userSl()));
  userSl.registerLazySingleton(
      () => UserForgetPassword(userRepository: userSl()));
  userSl.registerLazySingleton(() => UserSignOut(userRepository: userSl()));
  userSl.registerLazySingleton(() => DeleteUserUseCase(userSl()));

  // sign_up use_cases
  userSl.registerLazySingleton(() => UserSignUp(userRepository: userSl()));
  userSl
      .registerLazySingleton(() => UserVerification(userRepository: userSl()));

  //repository
  userSl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: userSl()));

  //datasources
  userSl.registerLazySingleton<UserRemoteDataSource>(() =>
      UserRemoteDataSourceImpl(
          firebaseMessaging: userSl(),
          auth: userSl(),
          dio: userSl(),
          sharedPreferences: userSl(),
          googleSignIn: userSl(),
          facebookAuth: userSl()));

  //external
  userSl.registerLazySingleton(() => FirebaseMessaging.instance);
  userSl.registerLazySingleton(() => GoogleSignIn(scopes: ['email']));
  userSl.registerLazySingleton(() => FacebookAuth.instance);
  userSl.registerLazySingleton(() => FirebaseAuth.instance);
}
