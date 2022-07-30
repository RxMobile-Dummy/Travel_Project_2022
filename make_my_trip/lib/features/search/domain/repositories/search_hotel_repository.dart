import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../data/models/search_hotel_model.dart';

abstract class SearchHotelRepository {
  Future<Either<Failures, List<SearchHotelModel>>> getNearByPlacesList(
      String place);
}
