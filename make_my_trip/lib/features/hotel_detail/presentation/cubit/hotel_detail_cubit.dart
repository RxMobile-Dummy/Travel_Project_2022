import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/home_page/data/models/ToursModel.dart';
import 'package:make_my_trip/features/hotel_detail/domain/repositories/hotel_detail_repository.dart';
import 'package:make_my_trip/features/hotel_detail/domain/use_cases/hotel_detail_usecase.dart';
import 'package:make_my_trip/features/hotel_detail/domain/use_cases/islike_delete_usecase.dart';
import 'package:make_my_trip/features/hotel_detail/domain/use_cases/islike_post_usecase.dart';
import '../../../../core/base/base_state.dart';

class HotelDetailCubit extends Cubit<BaseState> {
  HotelDetailCubit(
      this.hotelDetailUseCase, this.isLikePostUseCase, this.isLikeDeleteUseCase)
      : super(StateInitial()) {}

  bool islike = false;
  final HotelDetailUseCase hotelDetailUseCase;
  final IsLikePostUseCase isLikePostUseCase;
  final IsLikeDeleteUseCase isLikeDeleteUseCase;

  onLikeTap(bool isLiked, int? hotelId) {
    if (isLiked == true && hotelId != null) {
      isLikeDeleteUseCase.call(IsLikeDeleteParams(index: hotelId));
    } else if (isLiked == false && hotelId != null) {
      isLikePostUseCase.call(IsLikePostParams(index: hotelId));
    }
    emit(StateSearchResult<bool>(!isLiked));
  }

  onReadMoreTap(bool isReadMore) {
    emit(StateOnSuccess<bool>(!isReadMore));
  }

  onSwipeIndicator(index) {
    emit(StateOnResponseSuccess<int>(index));
  }

  getHotelDetailData(int data) async {
    emit(StateLoading());
    final res = await hotelDetailUseCase.call(HotelDetailParams(index: data));
    res.fold((l) => emit(StateNoData()),
        (r) => emit(StateOnKnownToSuccess<dynamic>(r)));
  }


}
