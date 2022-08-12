import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

import '../../../../core/failures/failures.dart';
import '../models/search_hotel_model.dart';

abstract class SearchHotelDataSources {
  Future<Either<Failures, List<SearchHotelModel>>> getNearByPlaces(
      String place);
}

class SearchHotelDataSourcesImpl implements SearchHotelDataSources {
  final Dio dio;
  SearchHotelDataSourcesImpl(this.dio);

  @override
  Future<Either<Failures, List<SearchHotelModel>>> getNearByPlaces(
    String place,
  ) async {
    try {
      final response = await dio.get("${BaseConstant.baseUrl}city/",
          queryParameters: {'searchdata': place.trim()},
          options: await BaseConstant.createDioOptions());
      if (response.statusCode == 200) {
        final List<SearchHotelModel> searchList = [];
        final jsonList = response.data;
        for (var item in jsonList) {
          searchList.add(SearchHotelModel.fromJson(item));
        }

        return Right(searchList);
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
