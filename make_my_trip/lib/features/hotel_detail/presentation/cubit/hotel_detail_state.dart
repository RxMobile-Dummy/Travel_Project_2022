abstract class HotelDetailState {}

class HotelDetailInitial extends HotelDetailState {}

class HotelDetailIsLikeState extends HotelDetailState {
  final bool isLiked;
  HotelDetailIsLikeState({required this.isLiked});
}

class HotelDetailIsReadMoreState extends HotelDetailState {
  final bool isReadMore;
  HotelDetailIsReadMoreState({required this.isReadMore});
}

class HotelDetailIndicatorIndexState extends HotelDetailState {
  final int index;
  HotelDetailIndicatorIndexState({required this.index});
}
