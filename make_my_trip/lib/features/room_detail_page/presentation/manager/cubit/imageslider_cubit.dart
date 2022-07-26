import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/room_detail_page/domain/use_cases/room_detail_usecase.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../user/domain/usecases/is_anonymous_user.dart';

class ImagesliderCubit extends Cubit<BaseState> {
  ImagesliderCubit(this.roomDetailUsecase, this.isAnonymousUser) : super(StateInitial());
  final RoomDetailUsecase roomDetailUsecase;
  final IsAnonymousUser isAnonymousUser;
  getindex(int i) {
    emit(StateOnSuccess<int>(i));
    return i;
  }
  goToBooking() async {
    final res = await isAnonymousUser.call(NoParams());
    res.fold((failure) {
      print(failure);
    }, (success) {
      if (success) {
        emit(Unauthenticated());
      } else {
        emit(Authenticated());
      }
    });
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
