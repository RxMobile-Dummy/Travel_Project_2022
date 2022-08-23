import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/room_detail_page/data/data_sources/room_detail_remote_data_source.dart';
import 'package:make_my_trip/features/room_detail_page/data/model/room_detail_model.dart';
import 'package:make_my_trip/features/room_detail_page/domain/repositories/room_detail_repository.dart';

class RoomDetailRepositoryImpl implements RoomDetailsRepository {
  final RoomDetailRemoteDataSource roomDetailRemoteDataSource;

  RoomDetailRepositoryImpl(this.roomDetailRemoteDataSource);
  @override
  Future<Either<Failures, RoomDetailModel>> getRoomDetail(
      int hotelId, int room_id) async {
    return await roomDetailRemoteDataSource.getRoomDetailData(hotelId, room_id);
  }
}
