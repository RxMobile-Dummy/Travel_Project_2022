import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_categories_model.dart';
import 'package:make_my_trip/features/room_categories/domain/repositories/room_categories_repository.dart';

class RoomCategoriesUseCase implements Usecase<RoomCategoryModel, Params> {
  final RoomCategoriesRepository roomCategoriesRepository;

  RoomCategoriesUseCase(this.roomCategoriesRepository);

  @override
  Future<Either<Failures, RoomCategoryModel>> call(Params params) async {
    return await roomCategoriesRepository.getRoomDetail(
        params.hotelId, params.cIn, params.cOut);
  }
}

class Params {
  final int hotelId;
  final String cIn;
  final String cOut;
  Params(this.hotelId, this.cIn, this.cOut);
}
