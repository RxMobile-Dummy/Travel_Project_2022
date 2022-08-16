import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/booking_history_details/data/data_sources/user_history_detail_datasource.dart';

import '../../../../utils/constants/base_constants.dart';

class UserHistoryDetailDataSourceImpl extends UserHistoryDetailDataSource {
  final Dio dio;

  UserHistoryDetailDataSourceImpl(this.dio);

  Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    return Options(headers: {'token': userToken});
  }

  @override
  Future<Either<Failures, String>> cancelBooking(bookingId) async {
    var deviceId = await FirebaseMessaging.instance.getToken();
    final response = await dio.put(
        '${BaseConstant.baseUrl}cancelbooking/$bookingId/$deviceId',
        options: await createDioOptions());
    if (response.statusCode == 200) {
      return const Right("Success");
    } else {
      return Left(ServerFailure());
    }
  }
}
