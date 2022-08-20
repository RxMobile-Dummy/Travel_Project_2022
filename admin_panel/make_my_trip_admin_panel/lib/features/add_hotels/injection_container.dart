import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/data_sources/hotel_dataSource_repositories.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/repositories/hotel_repositories_impl.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/repositories/hotel_repositories.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/add_hotel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/delete_hotel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/get_hotel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/get_hotelUpdate.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/update_hotel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/cubit/hotel_cubit.dart';
var sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => HotelCubit(postHotel: sl(),getHotel: sl(),deleteHotel: sl(), getHotelPut: sl(),updateHotel: sl()));
  // Use cases

  sl.registerLazySingleton(() => PostHotel(repository: sl()));
  sl.registerLazySingleton(() => GetAllHotel(repository: sl()));
  sl.registerLazySingleton(() => DeleteHotel(repository: sl()));
  sl.registerLazySingleton(() => GetHotelPut(repository: sl()));
  sl.registerLazySingleton(() => UpdateHotel(repository: sl()));

  sl.registerLazySingleton<HotelRepositories>(() => HotelRepositoriesImpl(repositories: sl()));
  sl.registerLazySingleton<HotelDataRourceRepositories>(() => HotelDataSourceRepositoriesImpl(dio: sl()));

  sl.registerLazySingleton(() => Dio());

}