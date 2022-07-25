import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/search/data/data_sources/search_hotel_data_sources.dart';
import 'package:make_my_trip/features/search/data/repositories/search_hotel_repository_impl.dart';
import 'package:make_my_trip/features/search/domain/repositories/search_hotel_repository.dart';
import 'package:make_my_trip/features/search/domain/use_cases/search_hotel_use_cases.dart';
import 'package:make_my_trip/features/search/presentation/cubit/search_hotel_cubit.dart';

var searchHotelSl = GetIt.instance;

Future<void> init() async {
  //cubit
  searchHotelSl.registerFactory(() => SearchHotelCubit(searchHotelSl()));

  //usecase
  searchHotelSl
      .registerLazySingleton(() => SearchHotelUseCases(searchHotelSl()));

  //repo
  searchHotelSl.registerLazySingleton<SearchHotelRepository>(
      () => SearchHotelRepositoryImpl(searchHotelSl()));

  //datsource
  searchHotelSl.registerLazySingleton<SearchHotelDataSources>(
      () => SearchHotelDataSourcesImpl(searchHotelSl()));
}
