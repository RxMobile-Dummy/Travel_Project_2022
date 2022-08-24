import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/features/review/domain/repositories/review_repository.dart';
import '../../../../core/usecases/usecase.dart';
class PostHotelReviewUseCases
    implements Usecase<void, PostReviewParams> {
  final ReviewRepository reviewRepository;
  PostHotelReviewUseCases(this.reviewRepository);
  @override
  Future<Either<Failures, void>> call(
      PostReviewParams postReviewParams) async {
    return await reviewRepository.postHotelReview(
        postReviewParams.reviewModel, postReviewParams.hotelid,postReviewParams.imageFileList);
  }
}
class PostReviewParams extends Equatable {
  final Reviews reviewModel;
  final int hotelid;
  final List<XFile> imageFileList;
  const PostReviewParams({required this.reviewModel, required this.hotelid,required this.imageFileList});
  @override
  List<Object?> get props => [reviewModel, hotelid];
}