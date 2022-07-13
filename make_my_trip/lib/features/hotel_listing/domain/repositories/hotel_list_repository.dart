import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../data/models/hotel_list_model.dart';

abstract class Hotel_List_Repository {
  Future<Either<Failures,List<HotelListModel>>>  get_hotel_list(String s);
}
