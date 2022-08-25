import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/home_page/data/models/imageModel.dart';

import '../../../hotel_listing/data/models/hotel_list_model.dart';

abstract class ImagesDataSource {
  Future<Either<Failures, List<HotelListModel>>> getList(int val);
}
