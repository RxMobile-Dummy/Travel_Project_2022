import 'package:equatable/equatable.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/data/models/review_model.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/domain/repositories/review_moderation_repository.dart';

import '../../../../core/usecases/usecase.dart';

class ApproveOrRejectReview extends UseCase<List<ReviewModel>, ApproveParams> {
  final ReviewModerationRepository repository;

  ApproveOrRejectReview({required this.repository});

  @override
  Future<Either<Failures, List<ReviewModel>>> call(ApproveParams params) async {
    return await repository.approveOrRejectReview(params);
  }
}

class ApproveParams extends Equatable {
  final int reviewId;
  final bool approved;

  const ApproveParams({required this.reviewId, required this.approved});

  @override
  List<Object?> get props => [reviewId, approved];
}
