import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/room_categories/data/data_sources/room_categories_data_source.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_categories_model.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';
import 'package:make_my_trip/features/room_categories/domain/repositories/room_categories_repository.dart';

import '../../../booking/data/model/booking_model.dart';

class RoomCategoriesRepositoryImpl implements RoomCategoriesRepository {
  final RoomCategoriesDataSource roomCategoriesDataSource;

  RoomCategoriesRepositoryImpl(this.roomCategoriesDataSource);

  @override
  Future<Either<Failures, RoomCategoryModel>> getRoomDetail(
      int hotelId, String cIn, String cOut, int noOfRooms) async {
    return await roomCategoriesDataSource.getRoomDetailData(
        hotelId, cIn, cOut, noOfRooms);
  }

  @override
  Future<Either<Failures, String>> roomBookPost(
      String orderId, String paymentId, BookingModel bookingModel) async {
    return await roomCategoriesDataSource.bookingPostData(
        orderId, paymentId, bookingModel);
  }
}
