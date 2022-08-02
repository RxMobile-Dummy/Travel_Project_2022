import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/room_detail_page/data/model/room_detail_model.dart';

abstract class RoomDetailsRepository {
  Future<Either<Failures, RoomDetailModel>> getRoomDetail(int hotelId,int room_id);
}
