import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_categories_model.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';

abstract class RoomCategoriesDataSource {
  Future<Either<Failures, RoomCategoryModel>> getRoomDetailData(int hotelId,String cIn,String cOut);

  Future<Either<Failures, String>> bookingPostData(int hotelId,
      RoomDataPostModel roomDataPostModel);
}

class RoomCategoriesDataSourceImpl implements RoomCategoriesDataSource {
  final Dio dio;
  final baseurl = BaseConstant.baseUrl;

  RoomCategoriesDataSourceImpl(this.dio);

  Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    return Options(headers: {'token': userToken});
  }

  @override
  Future<Either<Failures, RoomCategoryModel>> getRoomDetailData(
      int hotelId,String cIn,String cOut) async {
    try {
      final response = await dio.get(
          '${baseurl}booking/check', queryParameters: {
        "hotel_id": hotelId,
        "cin": cIn,
        "cout": cOut
      },options: await createDioOptions());
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

  @override
  Future<Either<Failures, String>> bookingPostData(int hotelId,
      RoomDataPostModel roomDataPostModel) async {
    try {
      print("Data source impl");
      final response = await dio.post(
          '${baseurl}booking/hotelbooking', data: roomDataPostModel.toJson(),options: await createDioOptions());
      print('this code ${response.statusCode}');
      if (response.statusCode == 200) {
        return Right(response.data);
      }else if(response.statusCode == 406){
        return Right(response.data);
      }
      else {
        return Left(ServerFailure());
      }
    }
    catch (e) {
      return Left(ServerFailure());
    }
  }
}