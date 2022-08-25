import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/features/hotel_listing/data/data_sources/remote/hotel_list_datasource.dart';

import '../../../../../core/failures/failure_handler.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../utils/constants/base_constants.dart';
import '../../../domain/use_cases/hotel_list_usecase.dart';
import '../../models/hotel_list_model.dart';

class HotelListDataSourceImpl implements HotelListDataSource {
  final Dio dio;

  HotelListDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, List<HotelListModel>>> getHotelListData(
      Params params) async {
    try {
      const baseurl =
          "${BaseConstant.baseUrl}hotel/gethotellist/gethotelfilterlist";
      final response = await dio.get(baseurl,
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
          options: await BaseConstant.createDioOptions());

      final res = await FailureHandler.handleError(response);
      return res.fold((l) => Left(l), (r) {
        final List<HotelListModel> hotelList = [];
        final jsonList = response.data;

        for (var item in jsonList) {
          hotelList.add(HotelListModel.fromJson(item));
        }
        return right(hotelList);
      });
    } on SocketException {
      return Left(InternetFailure());
    } catch (err) {
      print(err);
      return Left(ServerFailure());
    }

  }
}
