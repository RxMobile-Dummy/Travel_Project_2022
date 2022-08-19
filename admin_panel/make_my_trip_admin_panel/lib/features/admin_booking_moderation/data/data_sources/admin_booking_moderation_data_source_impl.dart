import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/data/data_sources/admin_booking_moderation_data_source.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/data/models/booking_moderation_model.dart';
import 'package:make_my_trip_admin_panel/utils/constants/base_constants.dart';

class AdminBookingModerationDataSourceImpl
    implements AdminBookingModerationDataSource {
  final Dio dio;

  AdminBookingModerationDataSourceImpl(this.dio);

  Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    return Options(headers: {'token': userToken});
  }

  @override
  Future<Either<Failures, List<BookingModerationModel>>> getAllBookings(
      filterParams) async {
    try {
      var params = {
        "pagesize": 10,
        "page": filterParams.page,
        "date1": filterParams.checkInDate ?? "",
        "date2": filterParams.checkOutDate ?? "",
        "hotelname": filterParams.hotelname ?? "",
        "username": filterParams.username ?? ""
      };
      const baseurl = BaseConstant.baseUrl;
      final response = await dio.get('${baseurl}booking/getallbooking',
          options: await createDioOptions(), queryParameters: params);
      if (response.statusCode == 200) {
        final List<BookingModerationModel> bookingList = [];
        for (var item in response.data) {
          bookingList.add(BookingModerationModel.fromJson(item));
        }

        return right(bookingList);
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }
}
