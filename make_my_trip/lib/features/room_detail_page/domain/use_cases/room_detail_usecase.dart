
import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecase/usecase.dart';
import 'package:make_my_trip/features/room_detail_page/data/model/room_detail_model.dart';
import 'package:make_my_trip/features/room_detail_page/domain/repositories/room_detail_repository.dart';

class RoomDetailUsecase implements  Usecase<RoomDetailsModel , Params>{
  final RoomDetailsRepository roomDetailsRepository;

  RoomDetailUsecase(this.roomDetailsRepository);

  @override
  Future<Either<Failures, RoomDetailsModel>> call(Params params) async{
    print('usecase');
    return await roomDetailsRepository.getRoomDetail(params.hotelId, params.roomType);
  }
}

class Params {
  final int hotelId;
  final String roomType;

  Params(this.hotelId, this.roomType);
}