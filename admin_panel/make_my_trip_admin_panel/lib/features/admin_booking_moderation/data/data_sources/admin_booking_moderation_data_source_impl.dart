import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/data/data_sources/admin_booking_moderation_data_source.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/data/models/booking_moderation_model.dart';
import 'package:make_my_trip_admin_panel/utils/constants/base_constants.dart';

class AdminBookingModerationDataSourceImpl
    implements AdminBookingModerationDataSource {
  final Dio dio;

  AdminBookingModerationDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, List<BookingModerationModel>>> getAllBookings(
      filterParams) async {
    try {
      var params = {
        "pagesize": 10,
        "page": filterParams.page,
        "date1": filterParams.checkInDate ??
            DateTime.now().toString().substring(0, 10),
        "date2": filterParams.checkOutDate ?? "",
        "hotelname": filterParams.hotelname ?? "",
        "username": filterParams.username ?? ""
      };
      const baseurl = BaseConstant.baseUrl;
      final response = await dio.get('${baseurl}booking/getallbooking',
          options: await BaseConstant.createDioOptions(),
          queryParameters: params);
      if (response.statusCode == 200) {
        final List<BookingModerationModel> bookingList = [];
        for (var item in response.data) {
          bookingList.add(BookingModerationModel.fromJson(item));
        }
        return right(bookingList);
      } else {
        return Left(ServerFailure());
      }
    } on SocketException {
      return Left(InternetFailure());
    } on DioError {
      return Left(ServerFailure());
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
