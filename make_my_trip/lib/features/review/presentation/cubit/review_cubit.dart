import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/features/review/domain/use_cases/get_hotel_review_usecase.dart';
import 'package:make_my_trip/features/review/domain/use_cases/post_hotel_review_usecase.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../user/domain/usecases/is_anonymous_user.dart';

class ReviewCubit extends Cubit<BaseState> {
  final GetHotelReviewUseCases getHotelReviewUseCases;
  final PostHotelReviewUseCases postHotelReviewUseCases;

  ReviewCubit(this.getHotelReviewUseCases, this.postHotelReviewUseCases,
      this.isAnonymousUser)
      : super(StateOnSuccess<ReviewValueState>(ReviewValueState(
      authenticated: false,
      cleanlinessReview: 0.0,
      comfortReview: 0.0,
      locationReview: 0.0,
      facilitiesReview: 0.0,
      commentReview: "")));

  final IsAnonymousUser isAnonymousUser;

  onChangeCleanlinessReviewValueEvent(double? cleanlinessRating) {
    emit(StateOnSuccess((state as StateOnSuccess<ReviewValueState>)
        .response
        .copyWith(cleanlinessReview: cleanlinessRating)));
  }

  onChangeComfortReviewValueEvent(double comfortRating) {
    emit(StateOnSuccess((state as StateOnSuccess<ReviewValueState>)
        .response
        .copyWith(comfortReview: comfortRating)));
  }

  onChangeLocationReviewValueEvent(double locationRating) {
    emit(StateOnSuccess((state as StateOnSuccess<ReviewValueState>)
        .response
        .copyWith(locationReview: locationRating)));
  }

  onChangeFacilitiesReviewValueEvent(double facilitiesRating) {
    emit(StateOnSuccess((state as StateOnSuccess<ReviewValueState>)
        .response
        .copyWith(facilitiesReview: facilitiesRating)));
  }

  onChangeCommentReviewValueEvent(String comment) {
    emit(StateOnSuccess((state as StateOnSuccess<ReviewValueState>)
        .response
        .copyWith(commentReview: comment)));
  }

  getHotelReviewData(int params) async {
    // emit(StateLoading());
    final res = await getHotelReviewUseCases.call(params);
    res.fold((l) => {print('print fail')},
        (r) => emit(StateOnSuccess<List<ReviewModel?>>(r)));
  }

  goToPostReview() async {
    final res = await isAnonymousUser.call(NoParams());
    res.fold((failure) {
      print(failure);
    }, (success) {
      if (success) {
        emit(StateOnSuccess((state as StateOnSuccess<ReviewValueState>)
            .response
            .copyWith(authenticated: false)));
      } else {
        emit(StateOnSuccess((state as StateOnSuccess<ReviewValueState>)
            .response
            .copyWith(authenticated: true)));
      }
    });
  }

  postHotelReviewData(ReviewModel reviewModel, int hote_id) async {
    if (reviewModel.comment == "" || reviewModel.comment == null) {
      emit(ValidationError("Please Enter Comment"));
    } else {
      final req = await postHotelReviewUseCases
          .call(PostReviewParams(hotel_id: hote_id, reviewModel: reviewModel));
      req.fold((l) {
        // emit(StateNoData());
      }, (r) {
        emit(StateOnKnownToSuccess<List<ReviewModel>>(r));
      });
    }
  }
}
