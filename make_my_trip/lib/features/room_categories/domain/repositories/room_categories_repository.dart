import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_categories_model.dart';

abstract class RoomCategoriesRepository{
  Future<Either<Failures, RoomCategoryModel>> getRoomDetail(int hotelId);
}