import 'package:bloc/bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/room_categories/domain/use_cases/room_categories_usecase.dart';

class RoomCategoryCubit extends Cubit<BaseState> {
  RoomCategoryCubit(this.roomCategoriesUseCase) : super(StateInitial()) {
    getData(3);
  }

  final RoomCategoriesUseCase roomCategoriesUseCase;

  getData(int hotelId) async {
    var res = await roomCategoriesUseCase.call(Params(hotelId));
    res.fold((l) => {print(l)}, (r) => emit(StateOnKnownToSuccess(r)));
  }
}
