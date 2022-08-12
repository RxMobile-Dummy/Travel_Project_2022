import 'package:dio/dio.dart';
import 'package:make_my_trip/features/hotel_listing/data/data_sources/local/hotel_listing_local_data_source.dart';
import 'package:make_my_trip/features/hotel_listing/data/data_sources/remote/hotel_listing_remote_data_source.dart';
import 'package:make_my_trip/features/hotel_listing/domain/repositories/hotel_listing_repository.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/cubits/hotel_listing_cubit.dart';
import 'data/data_sources/local/hotel_listing_local_data_source_impl.dart';
import 'data/data_sources/remote/hotel_listing_remote_data_source_impl.dart';
import 'package:get_it/get_it.dart';

import 'data/repositories/hotel_listing_repository_impl.dart';
import 'domain/use_cases/upload_user_info_use_case.dart';

final sl = GetIt.instance;

Future<void> initializeHotelListingFeature() async {
//data source
  sl.registerLazySingleton<HotelListingRemoteDataSource>(
      () => HotelListingRemoteDataSourceImpl());
  sl.registerLazySingleton<HotelListingLocalDataSource>(
      () => HotelListingLocalDataSourceImpl());

//repository
  sl.registerLazySingleton<HotelListingRepository>(() =>
      HotelListingRepositoryImpl(
          localDataSource: sl(), remoteDataSource: sl()));

//use cases
  sl.registerFactory<UploadUserInfoUseCase>(
      () => UploadUserInfoUseCase(hotelListingRepository: sl()));

//cubit
  sl.registerFactory<HotelListingCubit>(() => HotelListingCubit());

//external
  sl.registerLazySingleton(() => Dio());
}
