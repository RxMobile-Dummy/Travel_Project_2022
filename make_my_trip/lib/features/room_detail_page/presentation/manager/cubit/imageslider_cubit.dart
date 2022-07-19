import 'package:bloc/bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/room_detail_page/domain/use_cases/room_detail_usecase.dart';

class ImagesliderCubit extends Cubit<BaseState> {
  ImagesliderCubit(this.roomDetailUsecase) : super((StateInitial())) {
    getRoomData(1, "Deluxe");
  }

  final RoomDetailUsecase roomDetailUsecase;

  getindex(int i) {
    emit(StateOnSuccess<int>(i));
    return i;
  }

  onSwipeIndicator(int index) {
    emit(StateOnResponseSuccess<int>(index));
  }

  onReadMoreTap(bool isReadMore) {
    emit(StateOnSuccess<bool>(!isReadMore));
  }

  getRoomData(int hotelId, String roomType) async {
    var result = await roomDetailUsecase.call(Params(hotelId, roomType));
    result.fold((l) {
      if (l is ServerFailure) {
        emit(StateErrorGeneral(l.statusCode.toString()));
      }
    }, (r) => emit(StateOnKnownToSuccess<dynamic>(r)));
  }
}
