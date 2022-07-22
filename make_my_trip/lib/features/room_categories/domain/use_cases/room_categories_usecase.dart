import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecase/usecase.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_categories_model.dart';
import 'package:make_my_trip/features/room_categories/domain/repositories/room_categories_repository.dart';

class RoomCategoriesUseCase implements Usecase<RoomCategoryModel, Params> {
  final RoomCategoriesRepository roomCategoriesRepository;

  RoomCategoriesUseCase(this.roomCategoriesRepository);

  @override
  Future<Either<Failures, RoomCategoryModel>> call(Params params) async {
    return await roomCategoriesRepository.getRoomDetail(params.hotelId);
  }
}

class Params {
  final int hotelId;

  Params(this.hotelId);
}
