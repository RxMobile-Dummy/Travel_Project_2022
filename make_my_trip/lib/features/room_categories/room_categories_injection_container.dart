import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/room_categories/data/data_sources/room_categories_data_source.dart';
import 'package:make_my_trip/features/room_categories/data/repositories/room_categories_repository_impl.dart';
import 'package:make_my_trip/features/room_categories/domain/repositories/room_categories_repository.dart';
import 'package:make_my_trip/features/room_categories/domain/use_cases/room_categories_usecase.dart';
import 'package:make_my_trip/features/room_categories/presentation/cubit/room_category_cubit.dart';

var sl = GetIt.instance;

Future<void> init() async {
  //cubit
  sl.registerFactory(() => RoomCategoryCubit(sl()));

  //usecase
  sl.registerLazySingleton(() => RoomCategoriesUsecase(sl()));

  //repo
  sl.registerLazySingleton<RoomCategoriesRepository>(() => RoomCategoriesRepositoryImpl(sl()));

  //datsource

  sl.registerLazySingleton<RoomCategoriesDataSource>(() => RoomCategoriesDataSourceImpl(sl()));

  sl.registerLazySingleton(() => Dio());


}