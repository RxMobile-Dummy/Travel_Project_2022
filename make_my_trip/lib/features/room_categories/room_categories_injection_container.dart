import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/room_categories/data/data_sources/room_categories_data_source.dart';
import 'package:make_my_trip/features/room_categories/data/repositories/room_categories_repository_impl.dart';
import 'package:make_my_trip/features/room_categories/domain/repositories/room_categories_repository.dart';
import 'package:make_my_trip/features/room_categories/domain/use_cases/room_book_post_usecase.dart';
import 'package:make_my_trip/features/room_categories/domain/use_cases/room_categories_usecase.dart';
import 'package:make_my_trip/features/room_categories/presentation/cubit/room_category_cubit.dart';
import 'package:make_my_trip/features/room_categories/presentation/cubit/select_room_count.dart';

var roomCategorySl = GetIt.instance;

Future<void> init() async {
  //cubit
  roomCategorySl.registerFactory(() => RoomCategoryCubit(roomCategorySl(),roomCategorySl()));
  roomCategorySl.registerFactory(() => SelectRoomCountCubit());
  //usecase
  roomCategorySl
      .registerLazySingleton(() => RoomCategoriesUseCase(roomCategorySl()));
  roomCategorySl
      .registerLazySingleton(() => RoomBookPostUsecase(roomCategorySl()));

  //repo
  roomCategorySl.registerLazySingleton<RoomCategoriesRepository>(
          () => RoomCategoriesRepositoryImpl(roomCategorySl()));

  //datsource

  roomCategorySl.registerLazySingleton<RoomCategoriesDataSource>(
          () => RoomCategoriesDataSourceImpl(roomCategorySl()));

  // roomCategorySl.registerFactory(() => Dio());
}