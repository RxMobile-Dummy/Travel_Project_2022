

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/review/data/model/get_reviews_model.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';

abstract class ReviewRemoteDataSource {
  Future<Either<Failures, GetReviewModel>> getHotelReview(params);

  Future<Either<Failures, void>> postHotelReview(
      Reviews reviewModel, int hotel_id,List<String> imageFileList);



}
