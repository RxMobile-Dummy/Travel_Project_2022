import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/room_categories/data/data_sources/room_categories_data_source.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_categories_model.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';
import 'package:make_my_trip/features/room_categories/domain/repositories/room_categories_repository.dart';

class RoomCategoriesRepositoryImpl implements RoomCategoriesRepository {
  final RoomCategoriesDataSource roomCategoriesDataSource;

  RoomCategoriesRepositoryImpl(this.roomCategoriesDataSource);

  @override
  Future<Either<Failures, RoomCategoryModel>> getRoomDetail(int hotelId) async {
    return await roomCategoriesDataSource.getRoomDetailData(hotelId);
  }

  @override
  Future<Either<Failures, String>> roomBookPost(int hotelId, RoomDataPostModel roomDataPostModel) async {
    return await roomCategoriesDataSource.bookingPostData(hotelId, roomDataPostModel);
  }
}
