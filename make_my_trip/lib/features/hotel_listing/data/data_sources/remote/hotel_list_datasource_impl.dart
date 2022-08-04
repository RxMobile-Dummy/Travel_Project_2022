import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/features/hotel_listing/data/data_sources/remote/hotel_list_datasource.dart';

import '../../../../../core/failures/failures.dart';
import '../../../../../utils/constants/base_constants.dart';
import '../../../domain/use_cases/hotel_list_usecase.dart';
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
      Params params) async {
    try {
      // http://localhost:4000/hotel/gethotellist/gethotelfilterlist/?cin=2022-07-30&cout=2022-08-12&type=area&id=67&no_of_room=1&features=Parking&rating=1&price=4000-6000
      final baseurl =
          'http://192.168.102.56:4000/hotel/gethotellist/gethotelfilterlist';
      final response = await dio.get(
        baseurl,
        queryParameters: {
          'cin': params.cin,
          'cout': params.cout,
          'no_of_room': params.noOfRoom,
          'id': params.id,
          'type': params.type,
          'features': params.aminities,
          'rating': params.rating,
          'price': params.price
        },
      );
      print(response.realUri);
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
