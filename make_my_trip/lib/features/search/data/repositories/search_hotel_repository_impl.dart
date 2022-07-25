import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../domain/repositories/search_hotel_repository.dart';
import '../data_sources/search_hotel_data_sources.dart';
import '../models/search_hotel_model.dart';

class SearchHotelRepositoryImpl implements SearchHotelRepository {
  final SearchHotelDataSources searchHotelDataSources;

  SearchHotelRepositoryImpl(this.searchHotelDataSources);

  @override
  Future<Either<Failures, List<SearchHotelModel>>> getNearByPlacesList(
      String place) {
    return searchHotelDataSources.getNearByPlaces(place);
  }
}
