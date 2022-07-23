import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/features/review/domain/use_cases/get_hotel_review_usecase.dart';
import 'package:make_my_trip/features/review/domain/use_cases/post_hotel_review_usecase.dart';

class ReviewCubit extends Cubit<BaseState> {
  final GetHotelReviewUseCases getHotelReviewUseCases;
  final PostHotelReviewUseCases postHotelReviewUseCases;

  ReviewCubit(this.getHotelReviewUseCases, this.postHotelReviewUseCases)
      : super(StateInitial());

  getHotelReviewData(int params) async {
    emit(StateLoading());
    final res = await getHotelReviewUseCases.call(params);
    res.fold((l) => emit(StateNoData()),
        (r) => emit(StateOnSuccess<List<ReviewModel?>>(r)));
  }

  postHotelReviewData(ReviewModel reviewModel, int hote_id) async {
    if(reviewModel.comment == "" || reviewModel.comment == null  ){
      emit(ValidationError("Please Enter Comment"));
    }else {
    final req = await postHotelReviewUseCases
        .call(PostReviewParams(hotel_id: hote_id, reviewModel: reviewModel));
    req.fold((l) {
      emit(StateNoData());


    }, (r) {
      emit(StateOnKnownToSuccess<List<ReviewModel>>(r));

    });
  }
  }
}
