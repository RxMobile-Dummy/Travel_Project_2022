import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/user_history/data/data_sources/user_history_remote_data_source.dart';
import 'package:make_my_trip/features/user_history/data/repositories/user_history_repository_impl.dart';
import 'package:make_my_trip/features/user_history/domain/repositories/user_history_repository.dart';
import 'package:make_my_trip/features/user_history/domain/use_cases/user_history_usecase.dart';
import 'package:make_my_trip/features/user_history/presentation/cubit/user_history_cubit.dart';

var historyListSl = GetIt.instance;

Future<void> init() async {
  //cubit
  historyListSl.registerFactory(() => UserHistoryCubit(historyListSl()));

  //DataSource
  historyListSl.registerLazySingleton<UserHistoryDataSource>(
      () => UserHistoryDataSourceImpl(historyListSl()));

  //Repository
  historyListSl.registerLazySingleton<UserHistoryRepository>(
      () => UserHistoryRepositoryImpl(historyListSl()));

  //usecase
  historyListSl
      .registerLazySingleton(() => UserHistoryUsecase(historyListSl()));

  // historyListSl.registerFactory(() => Dio());
}
