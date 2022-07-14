import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/hotel_listing/data/data_sources/local/hotel_list_datasource_impl.dart';
import 'package:make_my_trip/features/hotel_listing/data/repositories/hotel_list_repository_impl.dart';
import 'package:make_my_trip/features/hotel_listing/domain/repositories/hotel_list_repository.dart';
import 'package:make_my_trip/features/hotel_listing/domain/use_cases/hotel_list_usecase.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/cubits/hotel_list_cubit.dart';

import 'data/data_sources/local/hotel_list_datasource.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //cubit
  sl.registerFactory<HotelListCubit>(
      () => HotelListCubit(hotellist_usecase: sl.call()));

  //usecases
  sl.registerLazySingleton<Hotellist_Usecase>(
      () => Hotellist_Usecase(hotel_list_repository: sl.call()));

  //repository
  sl.registerLazySingleton<Hotel_List_Repository>(
      () => Hotel_List_Repository_Impl(hotel_list_dataSource: sl.call()));
  //datasource
  sl.registerLazySingleton<Hotel_List_DataSource>(
      () => Hotel_List_DataSource_Impl());
}
