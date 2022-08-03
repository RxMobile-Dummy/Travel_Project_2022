import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/features/hotel_listing/data/data_sources/remote/hotel_list_datasource.dart';

import '../../../../../core/failures/failures.dart';
import '../../../../../utils/constants/base_constants.dart';
import '../../models/hotel_list_model.dart';

class HotelListDataSourceImpl implements HotelListDataSource {
  final Dio dio;

  HotelListDataSourceImpl(this.dio);
  Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    return Options(headers: {'token': userToken});
  }

  @override
  Future<Either<Failures, List<HotelListModel>>> getHotelListData(
      String cin, String cout, int noOfRoom, int id, String type) async {
    try {
      final baseurl =
          'http://192.168.101.124:4000/booking/hotellist/checkbooking';

      final response = await dio.get(
        baseurl,
        queryParameters: {
          'cin': cin,
          'cout': cout,
          'no_of_room': noOfRoom,
          'id': id,
          'type': type
        },
      );
      print(response.data);
      if (response.statusCode == 200) {
        final List<HotelListModel> hotelList = [];
        final jsonList = response.data;
        for (var item in jsonList) {
          hotelList.add(HotelListModel.fromJson(item));
        }
        return right(hotelList);
      } else if (response.statusCode == 505) {
        return Left(ServerFailure());
      } else if (response.statusCode == 404) {
        return Left(
            AuthFailure()); //Data Not Found Failure but in failure there is not method so AuthFailure
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      print(e);
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }
}
