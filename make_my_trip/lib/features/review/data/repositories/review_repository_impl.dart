import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/review/data/data_sources/review_remote_data_source.dart';
import 'package:make_my_trip/features/review/data/model/get_reviews_model.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/features/review/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource reviewRemoteDataSource;

  ReviewRepositoryImpl(this.reviewRemoteDataSource);

  @override
  Future<Either<Failures, GetReviewModel>> getHotelReview(int params) async {
    return await reviewRemoteDataSource.getHotelReview(params);
  }

  @override
  Future<Either<Failures, void>> postHotelReview(
      Reviews reviewModel, int hotel_id, List<String> imageFileList) async {
    return await reviewRemoteDataSource.postHotelReview(
        reviewModel, hotel_id, imageFileList);
  }
}
