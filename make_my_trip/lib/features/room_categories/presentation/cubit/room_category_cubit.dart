import 'package:bloc/bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';
import 'package:make_my_trip/features/room_categories/domain/use_cases/room_book_post_usecase.dart';
import 'package:make_my_trip/features/room_categories/domain/use_cases/room_categories_usecase.dart';

class RoomCategoryCubit extends Cubit<BaseState> {
  RoomCategoryCubit(this.roomCategoriesUseCase, this.roomBookPostUsecase) : super(StateInitial()) {
    getData(3);
  }

  final RoomCategoriesUseCase roomCategoriesUseCase;
  final RoomBookPostUsecase roomBookPostUsecase;

  getData(int hotelId) async {
    var res = await roomCategoriesUseCase.call(Params(hotelId));
    res.fold((l) => {print(l)}, (r) => emit(StateOnKnownToSuccess(r)));
  }

  roomBookPost(int hotelId,RoomDataPostModel roomDataPostModel)async {
    var res = await roomBookPostUsecase.call(RoomBookParams(hotelId,roomDataPostModel));
    res.fold((l) => {print(l)}, (r) => {print(r)});
  }
}
