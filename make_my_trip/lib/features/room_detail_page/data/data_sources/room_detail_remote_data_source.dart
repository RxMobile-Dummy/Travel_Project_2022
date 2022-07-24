import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/room_detail_page/data/model/room_detail_model.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';

abstract class RoomDetailRemoteDataSource {
  Future<Either<Failures, RoomDetailModel>> getRoomDetailData(
      int hotelId, int room_id);
}

class RoomDetailDataSourceImpl implements RoomDetailRemoteDataSource {
  final Dio dio;

  RoomDetailDataSourceImpl(this.dio);
  Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    return Options(headers: {'token': userToken});
  }
  @override
  Future<Either<Failures, RoomDetailModel>> getRoomDetailData(
      int hotelId, int room_id) async {
    try {
      final baseurl = '${BaseConstant.baseUrl}room/getroom/${hotelId}/${room_id}';
      final response = await dio.get(baseurl,options: await createDioOptions());
      print(response.data);
      if (response.statusCode == 200) {
        final RoomDetailModel roomDetailsModel =
        RoomDetailModel.fromJson(response.data);
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