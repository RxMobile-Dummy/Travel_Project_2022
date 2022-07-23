import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/hotel_detail/data/data_sources/hotel_detail_remote_data_source.dart';
import 'package:make_my_trip/features/hotel_detail/data/repositories/hotel_detail_repository_impl.dart';
import 'package:make_my_trip/features/hotel_detail/domain/repositories/hotel_detail_repository.dart';
import 'package:make_my_trip/features/hotel_detail/domain/use_cases/hotel_detail_usecase.dart';
import 'package:make_my_trip/features/hotel_detail/domain/use_cases/islike_delete_usecase.dart';
import 'package:make_my_trip/features/hotel_detail/domain/use_cases/islike_post_usecase.dart';
import 'package:make_my_trip/features/hotel_detail/presentation/cubit/hotel_detail_cubit.dart';

var hotelDetailSl = GetIt.instance;

Future<void> init() async {
  //cubit
  hotelDetailSl.registerFactory(() => HotelDetailCubit(hotelDetailSl(),hotelDetailSl(),hotelDetailSl()));

  //DataSource
  hotelDetailSl.registerLazySingleton<HotelDetailRemoteDataSource>(
      () => HotelDetailRemoteDataSourceImpl(hotelDetailSl()));

  //Repository
  hotelDetailSl.registerLazySingleton<HotelDetailRepository>(
      () => HotelDetailRepositoryImpl(hotelDetailSl()));

  //usecase
  hotelDetailSl
      .registerLazySingleton(() => HotelDetailUseCase(hotelDetailSl()));
  hotelDetailSl
      .registerLazySingleton(() => IsLikeDeleteUseCase(hotelDetailSl()));
  hotelDetailSl
      .registerLazySingleton(() => IsLikePostUseCase(hotelDetailSl()));
  // hotelDetailSl.registerFactory(() => Dio());
}
