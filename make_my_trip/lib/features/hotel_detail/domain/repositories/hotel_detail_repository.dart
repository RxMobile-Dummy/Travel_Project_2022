import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/hotel_detail/data/model/hotel_detail_model.dart';
import 'package:make_my_trip/features/hotel_detail/data/model/hotel_detail_model.dart';

import '../../../../core/failures/failures.dart';

abstract class HotelDetailRepository {
  Future<Either<Failures, HotelDetailModel>> getHotelDetails(int index);
}
