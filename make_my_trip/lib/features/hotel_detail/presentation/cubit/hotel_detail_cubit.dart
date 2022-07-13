import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/hotel_detail/presentation/cubit/hotel_detail_state.dart';

import '../../../../core/base/base_state.dart';

class HotelDetailCubit extends Cubit<BaseState> {
  HotelDetailCubit() : super(StateInitial());

  bool islike = false;

  onLikeTap(bool isLiked) {
    emit(StateSearchResult<bool>(!isLiked));
  }

  onReadMoreTap(bool isReadMore) {
    emit(StateOnSuccess<bool>(!isReadMore));
  }

  onSwipeIndicator(index) {
    emit(StateOnResponseSuccess<int>(index));
  }
}
