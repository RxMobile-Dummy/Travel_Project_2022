import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/hotel_detail/presentation/cubit/hotel_detail_state.dart';

class HotelDetailCubit extends Cubit<HotelDetailState> {
  HotelDetailCubit() : super(HotelDetailInitial());

  bool islike = false;

  onLikeTap(bool isLiked) {
    emit(HotelDetailIsLikeState(isLiked: !isLiked));
  }

  onReadMoreTap(bool isReadMore) {
    emit(HotelDetailIsReadMoreState(isReadMore: !isReadMore));
  }

  onSwipeIndicator(index) {
    emit(HotelDetailIndicatorIndexState(index: index));
  }
}
