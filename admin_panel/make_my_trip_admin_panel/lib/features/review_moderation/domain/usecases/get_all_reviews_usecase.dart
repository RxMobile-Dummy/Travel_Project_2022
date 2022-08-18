import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/data/models/review_model.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/domain/repositories/review_moderation_repository.dart';

import '../../../../core/usecases/usecase.dart';

class GetAllReviews extends UseCase<List<ReviewModel>, NoParams> {
  final ReviewModerationRepository repository;

  GetAllReviews({required this.repository});

  @override
  Future<Either<Failures, List<ReviewModel>>> call(NoParams params) async {
    return await repository.getAllReviews();
  }
}
