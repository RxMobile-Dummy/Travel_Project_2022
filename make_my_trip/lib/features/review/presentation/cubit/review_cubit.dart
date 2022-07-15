import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/features/review/domain/use_cases/get_hotel_review_usecase.dart';

class ReviewCubit extends Cubit<BaseState> {
  final GetHotelReviewUseCases getHotelReviewUseCases;

  ReviewCubit(this.getHotelReviewUseCases) : super(StateInitial()){
    getHotelReviewData(1);
  }

  getHotelReviewData(int params) async {
    final res = await getHotelReviewUseCases.call(params);
    res.fold((l) => emit(StateNoData()),
        (r) => emit(StateOnKnownToSuccess<dynamic>(r)));
  }
}
