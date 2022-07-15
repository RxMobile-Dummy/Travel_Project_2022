import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/review/data/data_sources/review_remote_data_source.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/features/review/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource reviewRemoteDataSource;

  ReviewRepositoryImpl(this.reviewRemoteDataSource);

  @override
  Future<Either<Failures, List<ReviewModel?>>> getHotelReview(int params) async {
    try {
      return Right(await reviewRemoteDataSource.getHotelReview(params));
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
