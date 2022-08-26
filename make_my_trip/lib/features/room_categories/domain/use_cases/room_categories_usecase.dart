import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/room_categories/domain/repositories/room_categories_repository.dart';

import '../../data/model/room_category_model.dart';

class RoomCategoriesUseCase implements Usecase<RoomCategoryModel, Params> {
  final RoomCategoriesRepository roomCategoriesRepository;

  RoomCategoriesUseCase(this.roomCategoriesRepository);

  @override
  Future<Either<Failures, RoomCategoryModel>> call(Params params) async {
    return await roomCategoriesRepository.getRoomDetail(
        params.hotelId, params.cIn, params.cOut, params.noOfRooms);
  }
}

class Params {
  final int hotelId;
  final String cIn;
  final String cOut;
  final int noOfRooms;
  Params(this.hotelId, this.cIn, this.cOut, this.noOfRooms);
}
