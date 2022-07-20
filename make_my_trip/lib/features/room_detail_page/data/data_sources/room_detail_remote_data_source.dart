import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/room_detail_page/data/model/room_detail_model.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';

abstract class RoomDetailRemoteDataSource {
  Future<Either<Failures, RoomDetailsModel>> getRoomDetailData(
      int hotelId, String roomType);
}

class RoomDetailDataSourceImpl implements RoomDetailRemoteDataSource {
  final Dio dio;

  RoomDetailDataSourceImpl(this.dio);
  @override
  Future<Either<Failures, RoomDetailsModel>> getRoomDetailData(
      int hotelId, String roomType) async {
    try {
      final baseurl = '${BaseConstant.baseUrl}room/${hotelId}/${roomType}';
      final response = await dio.get(baseurl);
      if (response.statusCode == 200) {
        final RoomDetailsModel roomDetailsModel =
            RoomDetailsModel.fromJson(response.data);
        return Right(roomDetailsModel);
      } else if (response.statusCode == 505) {
        return Left(ServerFailure());
      } else if (response.statusCode == 404) {
        return Left(
            AuthFailure()); //Data Not Found Failure but in failure there is not method so AuthFailure
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ServerFailure(statusCode: "503"));
    }
  }
}
