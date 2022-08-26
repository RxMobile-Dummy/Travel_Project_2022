import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/room_detail_page/data/data_sources/room_detail_remote_data_source.dart';
import 'package:make_my_trip/features/room_detail_page/data/repositories/room_detail_repository_impl.dart';
import 'package:make_my_trip/features/room_detail_page/domain/repositories/room_detail_repository.dart';
import 'package:make_my_trip/features/room_detail_page/domain/use_cases/room_detail_usecase.dart';
import 'package:make_my_trip/features/room_detail_page/presentation/manager/cubit/imageslider_cubit.dart';

var roomDetailSl = GetIt.instance;

Future<void> init() async {
  //cubit
  roomDetailSl
      .registerFactory(() => ImagesliderCubit(roomDetailSl(), roomDetailSl()));

  //usecase
  roomDetailSl.registerLazySingleton(() => RoomDetailUsecase(roomDetailSl()));

  //repo
  roomDetailSl.registerLazySingleton<RoomDetailsRepository>(
      () => RoomDetailRepositoryImpl(roomDetailSl()));

  //datsource

  roomDetailSl.registerLazySingleton<RoomDetailRemoteDataSource>(
      () => RoomDetailDataSourceImpl(roomDetailSl()));

  // roomDetailSl.registerFactory(() => Dio());
}
