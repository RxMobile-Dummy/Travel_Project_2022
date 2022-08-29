import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/review/data/model/get_reviews_model.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/features/review/domain/use_cases/get_hotel_review_usecase.dart';
import 'package:make_my_trip/features/review/domain/use_cases/post_hotel_review_usecase.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../user/domain/usecases/is_anonymous_user.dart';

class ReviewCubit extends Cubit<BaseState> {
  final GetHotelReviewUseCases getHotelReviewUseCases;
  final PostHotelReviewUseCases postHotelReviewUseCases;
  ReviewCubit(this.getHotelReviewUseCases, this.postHotelReviewUseCases,
      this.isAnonymousUser)
      : super(StateInitial());
  final IsAnonymousUser isAnonymousUser;
  getHotelReviewData(int params) async {
    emit(StateLoading());
    final res = await getHotelReviewUseCases.call(params);
    res.fold((l) => emit(StateErrorGeneral("errorMessage")),
        (r) => emit(StateOnSuccess<GetReviewModel>(r)));
  }

  postHotelReviewData(commentReview, cleanlinessReview, locationReview,
      comfortReview, facilitiesReview, hote_id, imageFileList) async {
    emit(StateLoading());
    Reviews reviewModel = Reviews(
      comment: commentReview,
      cleanliness: cleanlinessReview,
      comfort: comfortReview,
      location: locationReview,
      facilities: facilitiesReview,
    );
    if (reviewModel.comment!.isEmpty ||
        reviewModel.comment == null ||
        reviewModel.comment!.length == 0 ||
        reviewModel.comment!.toString().trim().length == 0) {
      emit(ValidationError(StringConstants.pleaseEntCom));
    } else {
      final req = await postHotelReviewUseCases.call(PostReviewParams(
          reviewModel: reviewModel,
          hotelid: hote_id,
          imageFileList: imageFileList));
      req.fold((l) {
        emit(StateErrorGeneral("errorMessage"));
      }, (r) {
        emit(StateNoData());
      });
    }
  }
}
