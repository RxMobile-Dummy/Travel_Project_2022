import 'package:bloc/bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';
import 'package:make_my_trip/features/room_categories/domain/use_cases/room_book_post_usecase.dart';
import 'package:make_my_trip/features/room_categories/domain/use_cases/room_categories_usecase.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../user/domain/usecases/is_anonymous_user.dart';
import '../../data/model/room_categories_model.dart';

class RoomCategoryCubit extends Cubit<BaseState> {
  RoomCategoryCubit(this.roomCategoriesUseCase, this.roomBookPostUsecase,
      this.isAnonymousUser)
      : super(StateInitial());

  final RoomCategoriesUseCase roomCategoriesUseCase;
  final RoomBookPostUsecase roomBookPostUsecase;
  final IsAnonymousUser isAnonymousUser;

  getData(int hotelId, String cIn, String cOut) async {
    emit(StateLoading());
    var res = await roomCategoriesUseCase.call(Params(hotelId, cIn, cOut));
    res.fold((l) => emit(StateErrorGeneral("errorMessage")),
        (r) => emit(StateOnKnownToSuccess<RoomCategoryModel>(r)));
  }


  postModelCreate(int hotelId, String cin, String cout, int noOfRoom,
      List<RoomType> roomType) {
    List<int> roomId = [];
    var dateCin = DateTime.parse(cin);
    var dateCout = DateTime.parse(cout);
    var noOfNights = dateCout.difference(dateCin).inDays;
    for (var i = 0; i < noOfRoom; i++) {
      if (roomType[i].roomId != null) {
        roomId.add(roomType[i].roomId!);
      }
    }
    Price p = Price(
        numberOfNights: noOfNights,
        basePrice: ((roomType[0].price ?? 1) * noOfRoom).toDouble(),
        roomPrice: (((roomType[0].price ?? 1) * noOfRoom).toDouble() *
            noOfNights),
        gst: ((((roomType[0].price ?? 1) * noOfRoom).toDouble() * noOfNights) *
            0.18),
        discount:
            ((((roomType[0].price ?? 1) * noOfRoom).toDouble() * noOfNights) +
                    ((((roomType[0].price ?? 1) * noOfRoom).toDouble() *
                            noOfNights) *
                        0.18)) *
                0.05,
        totalPrice: ((((roomType[0].price ?? 1) * noOfRoom).toDouble() *
                noOfNights) +
            ((((roomType[0].price ?? 1) * noOfRoom).toDouble() * noOfNights) *
                0.18) -
            ((((roomType[0].price ?? 1) * noOfRoom).toDouble() * noOfNights) +
                    ((((roomType[0].price ?? 1) * noOfRoom).toDouble() *
                            noOfNights) *
                        0.18)) *
                0.05));

    RoomDataPostModel roomDataPostModel = RoomDataPostModel(
        hotelId: hotelId,
        checkinDate: cin,
        checkoutDate: cout,
        noOfRoom: noOfRoom,
        roomType: roomType[0].roomType,
        price: p,
        roomId: roomId);
    emit(StateOnKnownToSuccess<RoomDataPostModel>(roomDataPostModel));
  }

  goToBooking(hotelId, cin, cout, totalSelectedRoom, roomList) async {
    emit(Uninitialized());
    final res = await isAnonymousUser.call(NoParams());
    res.fold((failure) {
    }, (success) {
      if (success) {
        emit(Unauthenticated());
      } else {
        postModelCreate(hotelId, cin, cout, totalSelectedRoom, roomList);
      }
    });
  }
}
