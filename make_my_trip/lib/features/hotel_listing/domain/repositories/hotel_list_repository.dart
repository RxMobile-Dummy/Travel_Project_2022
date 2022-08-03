import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../data/models/hotel_list_model.dart';

abstract class HotelListRepository {
  Future<Either<Failures, List<HotelListModel>>> getHotelList(
      String cin, String cout, int noOfRoom, int id, String type);
}
