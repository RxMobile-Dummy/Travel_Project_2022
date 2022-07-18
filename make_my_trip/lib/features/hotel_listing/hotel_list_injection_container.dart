import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/hotel_listing/data/data_sources/remote/hotel_list_datasource.dart';
import 'package:make_my_trip/features/hotel_listing/data/data_sources/remote/hotel_list_datasource_impl.dart';
import 'package:make_my_trip/features/hotel_listing/data/repositories/hotel_list_repository_impl.dart';
import 'package:make_my_trip/features/hotel_listing/domain/repositories/hotel_list_repository.dart';
import 'package:make_my_trip/features/hotel_listing/domain/use_cases/hotel_list_usecase.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/cubits/hotel_list_cubit.dart';


GetIt sl = GetIt.instance;

// Future<void> init() async {
//   //cubit
//   sl.registerFactory<HotelListCubit>(
//       () => HotelListCubit(hotellistUsecase: sl.call()));
//
//   //usecases
//   sl.registerLazySingleton<HotellistUsecase>(
//       () => HotellistUsecase(hotelListRepository: sl.call()));
//
//   //repository
//   sl.registerLazySingleton<HotelListRepository>(
//       () => HotelListRepositoryImpl(hotel_list_dataSource: sl.call()));
//   //datasource
//   sl.registerLazySingleton<HotelListDataSource>(
//       () => HotelListDataSourceImpl());
// }



Future<void> init() async {
  sl.registerFactory(() => HotelListCubit( hotelListUsecase: sl()));

  sl.registerLazySingleton(() => HotelListUsecase(sl()));

  sl.registerLazySingleton<HotelListRepository>(() => HotelListRepositoryImpl(hotelListDataSource: sl()));

  sl.registerFactory<HotelListDataSource>(() => HotelListDataSourceImpl(sl()));

  sl.registerLazySingleton(() => Dio());
}