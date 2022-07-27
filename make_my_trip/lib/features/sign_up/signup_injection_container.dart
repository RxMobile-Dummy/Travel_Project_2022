// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get_it/get_it.dart';
// import 'package:make_my_trip/features/sign_up/data/data_sources/sign_up_remote_datasource_impl.dart';
// import 'package:make_my_trip/features/sign_up/domain/repositories/sign_up_repository.dart';
// import 'package:make_my_trip/features/user/domain/usecases/user_sign_up.dart';
// import 'package:make_my_trip/features/user/domain/usecases/user_verification.dart';
// import 'package:make_my_trip/features/sign_up/presentation/cubit/sign_up_cubit.dart';
//
// import 'data/repositories/sign_up_repository_impl.dart';
//
// final signUpSl = GetIt.instance;
//
// Future<void> init() async {
//   signUpSl.registerFactory(
//       () => SignUpCubit(userSignUp: signUpSl(), userVerification: signUpSl()));
//
//   //usecase
//   signUpSl.registerLazySingleton(() => UserSignUp(repository: signUpSl()));
//   signUpSl
//       .registerLazySingleton(() => UserVerification(repository: signUpSl()));
//
//   //repository
//   signUpSl.registerLazySingleton<SignUpRepository>(
//       () => SignUpRepositoryImpl(remoteDataSource: signUpSl()));
//
//   //datasources
//   signUpSl.registerLazySingleton<SignUpRemoteDataSource>(() =>
//       SignUpRemoteDataSourceImpl(
//           auth: signUpSl(), dio: signUpSl(), sharedPreferences: signUpSl()));
//
//   //external
//   // signUpSl.registerLazySingleton(() => FirebaseAuth.instance);
// }
