import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';

abstract class ReviewRepository {
  Future<Either<Failures, List<ReviewModel?>>> getHotelReview(int params);

  Future<Either<Failures, List<ReviewModel>>> postHotelReview(ReviewModel reviewModel,int hotel_id);
}
