import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecases.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/features/review/domain/repositories/review_repository.dart';

class GetHotelReviewUseCases implements UseCase<List<ReviewModel?>, int> {
  final ReviewRepository reviewRepository;

  GetHotelReviewUseCases(this.reviewRepository);

  @override
  Future<Either<Failures, List<ReviewModel?>>> call(int params) async {
    return await reviewRepository.getHotelReview(params);
  }
}
