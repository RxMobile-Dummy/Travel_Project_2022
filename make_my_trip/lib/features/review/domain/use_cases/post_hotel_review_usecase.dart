import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/features/review/domain/repositories/review_repository.dart';

import '../../../../core/usecases/usecase.dart';

class PostHotelReviewUseCases
    implements Usecase<List<ReviewModel>, PostReviewParams> {
  final ReviewRepository reviewRepository;

  PostHotelReviewUseCases(this.reviewRepository);

  @override
  Future<Either<Failures, List<ReviewModel>>> call(
      PostReviewParams postReviewParams) async {
    return await reviewRepository.postHotelReview(
        postReviewParams.reviewModel, postReviewParams.hotel_id);
  }
}

class PostReviewParams extends Equatable {
  final ReviewModel reviewModel;
  final int hotel_id;

  const PostReviewParams({required this.reviewModel, required this.hotel_id});

  @override
  List<Object?> get props => [reviewModel, hotel_id];
}
