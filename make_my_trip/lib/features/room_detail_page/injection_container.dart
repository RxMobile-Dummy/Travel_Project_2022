import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/room_detail_page/data/data_sources/room_detail_remote_data_source.dart';
import 'package:make_my_trip/features/room_detail_page/data/repositories/room_detail_repository_impl.dart';
import 'package:make_my_trip/features/room_detail_page/domain/repositories/room_detail_repository.dart';
import 'package:make_my_trip/features/room_detail_page/domain/use_cases/room_detail_usecase.dart';
import 'package:make_my_trip/features/room_detail_page/presentation/manager/cubit/imageslider_cubit.dart';

var sl = GetIt.instance;

Future<void> init() async {
  //cubit
  sl.registerFactory(() => ImagesliderCubit(sl()));

  //usecase
  sl.registerLazySingleton(() => RoomDetailUsecase(sl()));

  //repo
  sl.registerLazySingleton<RoomDetailsRepository>(() => RoomDetailRepositoryImpl(sl()));

  //datsource

  sl.registerLazySingleton<RoomDetailRemoteDataSource>(() => RoomDetailDataSourceImpl(sl()));

  sl.registerLazySingleton(() => Dio());


}