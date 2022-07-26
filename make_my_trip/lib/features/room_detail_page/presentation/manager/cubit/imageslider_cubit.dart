import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/room_detail_page/domain/use_cases/room_detail_usecase.dart';

class ImagesliderCubit extends Cubit<BaseState> {
  ImagesliderCubit(this.roomDetailUsecase) : super(StateInitial());
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

  getRoomData(int hotelId, int room_id) async {
    emit(StateLoading());
    var result = await roomDetailUsecase.call(Params(hotelId, room_id));
    result.fold((l) {
      if (l is ServerFailure) {
        emit(StateErrorGeneral(l.statusCode.toString()));
      }
    }, (r) => emit(StateOnKnownToSuccess<dynamic>(r)));
  }

}

  // void addRoomEvent(int addRoomValue,int maxRoomCount) {
  //   if(addRoomValue<maxRoomCount) {
  //       emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
  //           .response
  //           .copyWith(Value: addRoomValue + 1)));
  //   }
  // }
  //
  // void removeRoomEvent(int removeRoomValue) {
  //   print('cubit');
  //   if (removeRoomValue > 0) {
  //       emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
  //           .response
  //           .copyWith(Value: removeRoomValue - 1)));
  //   }
  // }

// }