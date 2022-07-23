import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/user/domain/usecases/is_anonymous_user.dart';
import 'package:make_my_trip/features/user/presentation/cubit/user_cubit.dart';

import 'data/datasources/user_remote_data_source.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';

final userSl = GetIt.instance;

Future<void> init() async {
  userSl.registerFactory(() => UserCubit(
        isAnonymousUser: userSl(),
      ));

  //usecase
  userSl.registerLazySingleton(() => IsAnonymousUser(repository: userSl()));

  //repository
  userSl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: userSl()));

  //datasources
  userSl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(auth: userSl()));

  //external
}
