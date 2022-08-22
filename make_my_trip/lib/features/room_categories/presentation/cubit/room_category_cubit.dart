import 'package:bloc/bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';
import 'package:make_my_trip/features/room_categories/domain/use_cases/room_book_post_usecase.dart';
import 'package:make_my_trip/features/room_categories/domain/use_cases/room_categories_usecase.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../user/domain/usecases/is_anonymous_user.dart';
import '../../data/model/room_category_model.dart';

class RoomCategoryCubit extends Cubit<BaseState> {
  RoomCategoryCubit(this.roomCategoriesUseCase, this.roomBookPostUsecase,
      this.isAnonymousUser)
      : super(StateInitial());

  final RoomCategoriesUseCase roomCategoriesUseCase;
  final RoomBookPostUsecase roomBookPostUsecase;
  final IsAnonymousUser isAnonymousUser;

  getData(int hotelId, String cIn, String cOut, int noOfRooms) async {
    emit(StateLoading());
    var res =
        await roomCategoriesUseCase.call(Params(hotelId, cIn, cOut, noOfRooms));
    res.fold((l) => emit(StateErrorGeneral("errorMessage")),
        (r) => emit(StateOnKnownToSuccess<RoomCategoryModel>(r)));
  }

  postModelCreate(int hotelId, String cin, String cout, int noOfRoom,
      Map roomData, RoomCategoryModel roomCategoryModel, int adults) {
    List<int> roomId = [];
    for (var i = 0; i < roomData[roomCategoryModel.deluxe!.roomType]; i++) {
      roomId.add(roomCategoryModel.deluxeRoomId![i]);
    }
    for (var i = 0; i < roomData[roomCategoryModel.semideluxe!.roomType]; i++) {
      roomId.add(roomCategoryModel.semideluxeRoomId![i]);
    }
    for (var i = 0; i < roomData[roomCategoryModel.supedeluxe!.roomType]; i++) {
      roomId.add(roomCategoryModel.superdeluxeRoomId![i]);
    }

    RoomDataPostModel roomDataPostModel = RoomDataPostModel(
        hotelId: hotelId,
        checkinDate: cin,
        checkoutDate: cout,
        noOfRoom: noOfRoom,
        roomId: roomId,
        adults: adults);
    emit(StateOnKnownToSuccess<RoomDataPostModel>(roomDataPostModel));
  }

  goToBooking(hotelId, cin, cout, totalSelectedRoom, roomList,
      RoomCategoryModel roomCategoryModel, int adults) async {
    emit(StateInitial());
    final res = await isAnonymousUser.call(NoParams());
    res.fold((failure) {}, (success) {
      if (success) {
        emit(Unauthenticated());
      } else {
        postModelCreate(int.parse(hotelId), cin, cout, totalSelectedRoom,
            roomList, roomCategoryModel, adults);
      }
    });
  }
}
