import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/hotel_listing/data/data_sources/remote/hotel_list_datasource.dart';
import 'package:make_my_trip/features/hotel_listing/data/data_sources/remote/hotel_list_datasource_impl.dart';
import 'package:make_my_trip/features/hotel_listing/data/repositories/hotel_list_repository_impl.dart';
import 'package:make_my_trip/features/hotel_listing/domain/repositories/hotel_list_repository.dart';
import 'package:make_my_trip/features/hotel_listing/domain/use_cases/hotel_list_usecase.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/cubits/hotel_list_cubit.dart';

GetIt hotelListSl = GetIt.instance;

Future<void> init() async {
  hotelListSl
      .registerFactory(() => HotelListCubit(hotelListUsecase: hotelListSl()));

  hotelListSl.registerLazySingleton(() => HotelListUsecase(hotelListSl()));

  hotelListSl.registerLazySingleton<HotelListRepository>(
      () => HotelListRepositoryImpl(hotelListDataSource: hotelListSl()));

  hotelListSl.registerFactory<HotelListDataSource>(
      () => HotelListDataSourceImpl(hotelListSl()));
}
