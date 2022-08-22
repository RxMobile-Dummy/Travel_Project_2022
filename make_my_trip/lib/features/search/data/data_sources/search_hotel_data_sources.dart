import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

import '../../../../core/failures/failures.dart';
import '../models/search_hotel_model.dart';

abstract class SearchHotelDataSources {
  Future<Either<Failures, List<SearchHotelModel>>> getNearByPlaces(
      String place);
}

class SearchHotelDataSourcesImpl implements SearchHotelDataSources {
  final Dio dio;
  final String baseURL = StringConstants.googleApiUrl;
  final String kPLACES_API_KEY = 'AIzaSyAcmpKXz5KH8e7zmPkHNIIUuSBXI8qEBNs';

  SearchHotelDataSourcesImpl(this.dio);

  @override
  Future<Either<Failures, List<SearchHotelModel>>> getNearByPlaces(
      String place) async {
    try {
      String request = '$baseURL?input=$place&key=$kPLACES_API_KEY';
      var response = await dio.get(request);
      if (response.statusCode == 200) {
        final searchList = <SearchHotelModel>[];
        final jsonList = response.data['predictions'];
        for (var item in jsonList) {
          searchList.add(SearchHotelModel(
              description: item["description"],
              placeId: item["place_id"],
              reference: item["reference"]));
        }
        return Right(searchList);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
