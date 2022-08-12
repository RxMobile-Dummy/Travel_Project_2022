import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/booking/domain/use_cases/booking_usecase.dart';
import 'package:make_my_trip/features/booking/presentation/cubit/book_cubit.dart';
import 'package:make_my_trip/features/booking/presentation/cubit/payment_integeration_cubit.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../booking/data/data_sources/booking_remote_data_source.dart';
import '../booking/data/repositories/booking_repository_impl.dart';
import '../booking/domain/repositories/booking_repository.dart';
import '../booking/domain/use_cases/payment_usecase.dart';
import '../user_history/data/data_sources/user_history_remote_data_source.dart';
import '../user_history/data/repositories/user_history_repository_impl.dart';
import '../user_history/domain/repositories/user_history_repository.dart';
import '../user_history/domain/use_cases/user_history_usecase.dart';
import '../user_history/presentation/cubit/user_history_cubit.dart';

var historyListDetailSl = GetIt.instance;

Future<void> init() async {
  //cubit
  historyListDetailSl
      .registerFactory(() => UserHistoryCubit(historyListDetailSl()));

  //DataSource
  historyListDetailSl.registerLazySingleton<UserHistoryDataSource>(
      () => UserHistoryDataSourceImpl(historyListDetailSl()));

  //Repository
  historyListDetailSl.registerLazySingleton<UserHistoryRepository>(
      () => UserHistoryRepositoryImpl(historyListDetailSl()));

  //usecase
  historyListDetailSl
      .registerLazySingleton(() => UserHistoryUsecase(historyListDetailSl()));

  // historyListSl.registerFactory(() => Dio());
}
