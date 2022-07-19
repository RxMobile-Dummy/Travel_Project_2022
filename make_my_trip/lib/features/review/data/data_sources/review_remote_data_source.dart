import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';

abstract class ReviewRemoteDataSource {
  Future<Either<Failures, List<ReviewModel?>>> getHotelReview(params);

  Future<Either<Failures, void>> postHotelReview(params);
}
