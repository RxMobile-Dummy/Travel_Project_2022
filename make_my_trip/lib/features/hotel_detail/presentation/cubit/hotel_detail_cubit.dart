import 'package:flutter_bloc/flutter_bloc.dart';
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
