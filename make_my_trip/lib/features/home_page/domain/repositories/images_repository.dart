import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/hotel_listing/data/models/hotel_list_model.dart';
import '../../../../core/failures/failures.dart';
import '../../data/models/imageModel.dart';

abstract class ImagesRepository {
  Future<Either<Failures, List<HotelListModel>>> getImages(int val);
}
