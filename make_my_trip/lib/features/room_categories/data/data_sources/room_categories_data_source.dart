import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';

import '../../../booking/data/model/booking_model.dart';
import '../model/room_category_model.dart';

abstract class RoomCategoriesDataSource {
  Future<Either<Failures, RoomCategoryModel>> getRoomDetailData(
      int hotelId, String cIn, String cOut, int noOfRooms);

  Future<Either<Failures, String>> bookingPostData(
      String orderId, String paymentId, BookingModel bookingModel);
}

class RoomCategoriesDataSourceImpl implements RoomCategoriesDataSource {
  final Dio dio;
  final baseurl = BaseConstant.baseUrl;

  RoomCategoriesDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, RoomCategoryModel>> getRoomDetailData(
      int hotelId, String cIn, String cOut, int noOfRooms) async {
    try {
      final response = await dio.get('${baseurl}booking/check',
          queryParameters: {
            "hotel_id": hotelId,
            "cin": cIn,
            "cout": cOut,
            "no_of_room": noOfRooms
          },
          options: await BaseConstant.createDioOptions());
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
  Future<Either<Failures, String>> bookingPostData(
      String orderId, String paymentId, BookingModel bookingModel) async {
    try {
      final response = await dio.post('${baseurl}booking/hotelbooking',
          data: bookingModel.toJson(),
          options: await BaseConstant.createDioOptions());

      if (response.statusCode == 200) {
        return Right(response.data);
      } else if (response.statusCode == 406) {
        return Right(response.data);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
