import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_categories_model.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';

abstract class RoomCategoriesDataSource {
  Future<Either<Failures, RoomCategoryModel>> getRoomDetailData(int hotelId);
}

class RoomCategoriesDataSourceImpl implements RoomCategoriesDataSource {
  final Dio dio;
  final baseurl = '${BaseConstant.baseUrl}booking/check';

  RoomCategoriesDataSourceImpl(this.dio);

  Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    return Options(headers: {'token': userToken});
  }

  @override
  Future<Either<Failures, RoomCategoryModel>> getRoomDetailData(
      int hotelId) async {
    try {
      final response = await dio.get(baseurl, queryParameters: {
        "hotel_id": '1',
        "cin": '2020-01-05',
        "cout": '2020-01-10'
      });
      if (response.statusCode == 200) {
        final RoomCategoryModel roomCategoryModel =
            RoomCategoryModel.fromJson(response.data);
        return Right(roomCategoryModel);
      } else if (response.statusCode == 500) {
        return Left(ServerFailure());
      } else if (response.statusCode == 404) {
        return Left(
            AuthFailure()); //Data Not Found Failure but in failure there is not method so AuthFailure
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
