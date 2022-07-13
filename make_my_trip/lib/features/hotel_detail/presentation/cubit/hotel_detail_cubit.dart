import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/hotel_detail/domain/repositories/hotel_detail_repository.dart';
import 'package:make_my_trip/features/hotel_detail/domain/use_cases/hotel_detail_usecase.dart';
import '../../../../core/base/base_state.dart';

class HotelDetailCubit extends Cubit<BaseState> {
  HotelDetailUseCase hotelDetailUseCase;

  HotelDetailCubit(this.hotelDetailUseCase) : super(StateInitial());

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

  dataGet() async {
    print('cubit');
    var res = await hotelDetailUseCase.call(5);
    res.fold((l) => {print('Fail')}, (r) => {print(r)});
  }
}
