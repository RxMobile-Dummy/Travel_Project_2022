import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/features/review/domain/repositories/review_repository.dart';

import '../../../../core/usecases/usecase.dart';

class GetHotelReviewUseCases implements Usecase<ReviewModel, int> {
  final ReviewRepository reviewRepository;

  GetHotelReviewUseCases(this.reviewRepository);

  @override
  Future<Either<Failures,ReviewModel>> call(int params) async {
    return await reviewRepository.getHotelReview(params);
  }
}
