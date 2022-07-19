import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_categories_model.dart';

abstract class RoomCategoriesDataSource {
  Future<RoomCategoryModel> getRoomDetailData(int hotelId);
}

class RoomCategoriesDataSourceImpl implements RoomCategoriesDataSource {
  final Dio dio;
  RoomCategoriesDataSourceImpl(this.dio);

  @override
  Future<RoomCategoryModel> getRoomDetailData(int hotelId) async {
    try {
      final baseurl = 'http://192.168.102.164:3000/room/${hotelId}';
      final response = await dio.get(baseurl);
      if (response.statusCode == 200) {
        final RoomCategoryModel roomCategoryModel =
            RoomCategoryModel.fromJson(response.data);
        return roomCategoryModel;
      } else if (response.statusCode == 505) {
        throw ServerFailure();
      } else if (response.statusCode == 404) {
        throw AuthFailure(); //Data Not Found Failure but in failure there is not method so AuthFailure
      } else {
        throw InternetFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }
}
