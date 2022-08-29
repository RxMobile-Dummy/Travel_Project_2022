import 'package:get_it/get_it.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/data_sources/hotel_data_source.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/data_sources/hotel_data_source_impl.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/repositories/hotel_repositories_impl.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/repositories/hotel_repositories.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/add_hotel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/add_image.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/delete_hotel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/get_hotel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/get_hotelUpdate.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/get_hotel_images.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/update_hotel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/cubit/hotel_cubit.dart';

var hotelSl = GetIt.instance;

Future<void> init() async {
  hotelSl.registerFactory(() => HotelCubit(
      postHotel: hotelSl(),
      getHotel: hotelSl(),
      deleteHotel: hotelSl(),
      getHotelPut: hotelSl(),
      updateHotel: hotelSl(),
      addImage: hotelSl(),
      getHotelImage: hotelSl()));
  // Use cases

  hotelSl.registerLazySingleton(() => PostHotel(repository: hotelSl()));
  hotelSl.registerLazySingleton(() => GetAllHotel(repository: hotelSl()));
  hotelSl.registerLazySingleton(() => DeleteHotel(repository: hotelSl()));
  hotelSl.registerLazySingleton(() => GetHotelPut(repository: hotelSl()));
  hotelSl.registerLazySingleton(() => UpdateHotel(repository: hotelSl()));
  hotelSl.registerLazySingleton(() => AddHotelImage(repository: hotelSl()));
  hotelSl.registerLazySingleton(() => GetHotelImages(repository: hotelSl()));

  hotelSl.registerLazySingleton<HotelRepositories>(
      () => HotelRepositoriesImpl(repositories: hotelSl()));
  hotelSl.registerLazySingleton<HotelDataSource>(
      () => HotelDataSourceImpl(dio: hotelSl()));
}
