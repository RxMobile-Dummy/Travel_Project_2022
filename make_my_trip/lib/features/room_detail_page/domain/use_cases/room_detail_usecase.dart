
import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecase/usecase.dart';
import 'package:make_my_trip/features/room_detail_page/data/model/room_detail_model.dart';
import 'package:make_my_trip/features/room_detail_page/domain/repositories/room_detail_repository.dart';

class RoomDetailUsecase implements  Usecase<RoomDetailModel , Params>{
  final RoomDetailsRepository roomDetailsRepository;

  RoomDetailUsecase(this.roomDetailsRepository);

  @override
  Future<Either<Failures, RoomDetailModel>> call(Params params) async{
    return await roomDetailsRepository.getRoomDetail(params.hotelId, params.room_id);
  }
}

class Params {
  final int hotelId;
  final int room_id;

  Params(this.hotelId, this.room_id);
}