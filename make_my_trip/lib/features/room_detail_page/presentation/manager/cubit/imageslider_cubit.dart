import 'package:bloc/bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_category_model.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';
import 'package:make_my_trip/features/room_detail_page/domain/use_cases/room_detail_usecase.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../user/domain/usecases/is_anonymous_user.dart';

class ImagesliderCubit extends Cubit<BaseState> {
  ImagesliderCubit(this.roomDetailUsecase, this.isAnonymousUser)
      : super(StateInitial());
  final RoomDetailUsecase roomDetailUsecase;
  final IsAnonymousUser isAnonymousUser;
  getindex(int i) {
    emit(StateOnSuccess<int>(i));
    return i;
  }

  goToBooking(hotelId, cin, cout, totalSelectedRoom, roomList) async {
    emit(Uninitialized());
    final res = await isAnonymousUser.call(NoParams());
    res.fold((failure) {}, (success) {
      if (success) {
        emit(Unauthenticated());
      } else {
        postModelCreate(hotelId, cin, cout, totalSelectedRoom, roomList);
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

  postModelCreate(int hotelId, String cin, String cout, int noOfRoom,
      List<Deluxe> roomType) {
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
        roomId: roomId);
    emit(StateSearchResult<RoomDataPostModel>(roomDataPostModel));
  }
}
