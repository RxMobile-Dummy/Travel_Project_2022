import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';

import '../../../booking/data/model/booking_model.dart';
import '../../data/model/room_category_model.dart';

abstract class RoomCategoriesRepository {
  Future<Either<Failures, RoomCategoryModel>> getRoomDetail(
      int hotelId, String cIn, String cOut, int noOfRooms);
  Future<Either<Failures, String>> roomBookPost(
      String orderId, String paymentId, BookingModel bookingModel);
}
