import 'package:dartz/dartz.dart';

import '../../../../../core/failures/failures.dart';
import '../../models/hotel_list_model.dart';

abstract class HotelListDataSource {
  Future<Either<Failures, List<HotelListModel>>> getHotelListData(String hotelName);
}
