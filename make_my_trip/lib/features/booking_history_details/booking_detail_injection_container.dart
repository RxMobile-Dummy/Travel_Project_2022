import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/booking_history_details/data/data_sources/user_history_detail_datasource_impl.dart';
import 'package:make_my_trip/features/booking_history_details/data/repositories/user_history_detail_repository_impl.dart';
import 'package:make_my_trip/features/booking_history_details/domain/repositories/user_history_detail_repository.dart';
import 'package:make_my_trip/features/booking_history_details/domain/use_cases/user_history_detail_usecase.dart';
import 'package:make_my_trip/features/booking_history_details/presentation/cubit/cancel_booking_cubit.dart';
import 'data/data_sources/user_history_detail_datasource.dart';

var historyListDetailSl = GetIt.instance;

Future<void> init() async {
  //cubit
  historyListDetailSl.registerFactory(() => CancelBookingCubit(historyListDetailSl()));

  //DataSource
  historyListDetailSl.registerLazySingleton<UserHistoryDetailDataSource>(() => UserHistoryDetailDataSourceImpl(historyListDetailSl()),);

  //Repository
  historyListDetailSl.registerLazySingleton<UserHistoryDetailRepository>(() => UserHistoryDetailRepositoryImpl(historyListDetailSl()));

  //usecase
  historyListDetailSl.registerLazySingleton(() => UserHistoryDetailUseCase(historyListDetailSl()));

  // historyListSl.registerFactory(() => Dio());
}
