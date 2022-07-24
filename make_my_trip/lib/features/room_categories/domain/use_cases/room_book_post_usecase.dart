import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';
import 'package:make_my_trip/features/room_categories/domain/repositories/room_categories_repository.dart';

import '../../../../core/usecases/usecase.dart';

class RoomBookPostUsecase implements Usecase<String, RoomBookParams> {
  final RoomCategoriesRepository roomCategoriesRepository;

  RoomBookPostUsecase(this.roomCategoriesRepository);

  @override
  Future<Either<Failures, String>> call(RoomBookParams params) async {
    return await roomCategoriesRepository.roomBookPost(params.hotelId , params.roomDataPostModel
    );
  }
}

class RoomBookParams {
  final int hotelId;
  final RoomDataPostModel roomDataPostModel;

  RoomBookParams(this.hotelId, this.roomDataPostModel);
}
