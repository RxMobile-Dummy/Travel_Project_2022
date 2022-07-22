import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/features/review/domain/repositories/review_repository.dart';

import '../../../../core/usecases/usecase.dart';

class PostHotelReviewUseCases implements Usecase<void, ReviewModel> {
  final ReviewRepository reviewRepository;

  PostHotelReviewUseCases(this.reviewRepository);

  @override
  Future<Either<Failures, void>> call(ReviewModel params) async {
    return await reviewRepository.postHotelReview(params);
  }
}
