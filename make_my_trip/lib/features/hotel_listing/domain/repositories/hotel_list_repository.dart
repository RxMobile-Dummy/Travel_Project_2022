import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../data/models/hotel_list_model.dart';
import '../use_cases/hotel_list_usecase.dart';

abstract class HotelListRepository {
  Future<Either<Failures, List<HotelListModel>>> getHotelList(Params params);
}
