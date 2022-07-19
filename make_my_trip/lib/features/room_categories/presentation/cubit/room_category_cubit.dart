import 'package:bloc/bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/room_categories/domain/use_cases/room_categories_usecase.dart';
import 'package:meta/meta.dart';

class RoomCategoryCubit extends Cubit<BaseState> {
  RoomCategoryCubit(this.roomCategoriesUsecase) : super(StateInitial()) {
    getData(3);
  }
  final RoomCategoriesUsecase roomCategoriesUsecase;

  getData(int hotelId) async {
    var res = await roomCategoriesUsecase.call(Params(hotelId));
    res.fold((l) => {print(l)}, (r) => emit(StateOnKnownToSuccess<dynamic>(r)));
  }

  onReadMoreTap(bool isReadMore) {
    emit(StateOnSuccess<bool>(!isReadMore));
  }
}
