import 'package:make_my_trip_admin_panel/features/review_moderation/data/datasources/review_moderation_remote_data_source.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/data/models/review_model.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/domain/repositories/review_moderation_repository.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/domain/usecases/review_Image_delete.dart';

import '../../domain/usecases/approve_or_reject_review_usecase.dart';

class ReviewModerationRepositoryImpl extends ReviewModerationRepository {
  final ReviewModerationRemoteDataSource remoteDataSource;

  ReviewModerationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<ReviewModel>>> getAllReviews() async {
    return await remoteDataSource.getAllReviews();
  }

  @override
  Future<Either<Failures, void>> approveOrRejectReview(
      ApproveParams params) async {
    return await remoteDataSource.approveOrRejectReview(params);
  }

  @override
  Future<Either<Failures, void>> reviewImageDelete(
      ReviewImageDeleteParams params) async {
    return await remoteDataSource.reviewImageDelete(params);
  }
}
