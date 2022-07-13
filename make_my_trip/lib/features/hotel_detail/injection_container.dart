import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/hotel_detail/data/data_sources/hotel_detail_remote_data_source.dart';
import 'package:make_my_trip/features/hotel_detail/data/repositories/hotel_detail_repository_impl.dart';
import 'package:make_my_trip/features/hotel_detail/domain/repositories/hotel_detail_repository.dart';
import 'package:make_my_trip/features/hotel_detail/domain/use_cases/hotel_detail_usecase.dart';
import 'package:make_my_trip/features/hotel_detail/presentation/cubit/hotel_detail_cubit.dart';

var sl = GetIt.instance;

Future<void> init() async {
  //cubit
  sl.registerFactory(() => HotelDetailCubit(sl()));

  //DataSource
  sl.registerLazySingleton<HotelDetailRemoteDataSource>(
      () => HotelDetailRemoteDataSourceImpl(sl()));

  //Repository
  sl.registerLazySingleton<HotelDetailRepository>(
      () => HotelDetailRepositoryImpl(sl()));

  //usecase
  sl.registerLazySingleton(() => HotelDetailUseCase(sl()));

  sl.registerLazySingleton(() => Dio());
}
