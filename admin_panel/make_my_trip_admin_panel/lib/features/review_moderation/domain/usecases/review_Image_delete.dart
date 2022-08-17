import 'package:equatable/equatable.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/data/models/review_model.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/domain/repositories/review_moderation_repository.dart';

import '../../../../core/usecases/usecase.dart';

class ReviewImageDelete
    extends UseCase<List<ReviewModel>, ReviewImageDeleteParams> {
  final ReviewModerationRepository repository;

  ReviewImageDelete({required this.repository});

  @override
  Future<Either<Failures, List<ReviewModel>>> call(
      ReviewImageDeleteParams params) async {
    return await repository.reviewImageDelete(params);
  }
}

class ReviewImageDeleteParams extends Equatable {
  final int reviewId, imageId;

  const ReviewImageDeleteParams(
      {required this.reviewId, required this.imageId});

  @override
  List<Object?> get props => [reviewId, imageId];
}
