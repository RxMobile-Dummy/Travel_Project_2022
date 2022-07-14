import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/hotel_detail/domain/repositories/hotel_detail_repository.dart';
import 'package:make_my_trip/features/hotel_detail/domain/use_cases/hotel_detail_usecase.dart';
import '../../../../core/base/base_state.dart';

class HotelDetailCubit extends Cubit<BaseState> {
  HotelDetailCubit(this.hotelDetailUseCase) : super(StateInitial()) {
    getHotelDetailData(6);
  }

  bool islike = false;
  final HotelDetailUseCase hotelDetailUseCase;

  onLikeTap(bool isLiked) {
    emit(StateSearchResult<bool>(!isLiked));
  }

  onReadMoreTap(bool isReadMore) {
    emit(StateOnSuccess<bool>(!isReadMore));
  }

  onSwipeIndicator(index) {
    emit(StateOnResponseSuccess<int>(index));
  }

  getHotelDetailData(int data) async {
    final res = await hotelDetailUseCase.call(Params(index: data));
    res.fold((l) => emit(StateNoData()),
        (r) => emit(StateOnKnownToSuccess<dynamic>(r)));
  }
}
