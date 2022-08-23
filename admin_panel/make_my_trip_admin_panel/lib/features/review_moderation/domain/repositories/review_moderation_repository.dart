import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/data/models/review_model.dart';

import '../usecases/approve_or_reject_review_usecase.dart';
import '../usecases/review_Image_delete.dart';

abstract class ReviewModerationRepository {
  Future<Either<Failures, List<ReviewModel>>> getAllReviews();
  Future<Either<Failures, void>> approveOrRejectReview(
      ApproveParams params);
  Future<Either<Failures, void>> reviewImageDelete(
      ReviewImageDeleteParams params);
}
