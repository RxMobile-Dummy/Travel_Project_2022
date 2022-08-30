import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/hotel_detail/data/model/hotel_detail_model.dart';
import 'package:make_my_trip/features/hotel_detail/domain/use_cases/hotel_detail_usecase.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';
import 'package:make_my_trip/features/room_categories/domain/use_cases/room_book_post_usecase.dart';

class BookingCubit extends Cubit<BaseState> {
  BookingCubit(this.roomBookPostUsecase, this.hotelDetailUseCase)
      : super(StateOnSuccess<CustomState>(CustomState()));

  RoomBookPostUsecase roomBookPostUsecase;
  HotelDetailUseCase hotelDetailUseCase;

  getHotelDetailData(data) async {
    final res =
        await hotelDetailUseCase.call(HotelDetailParams(index: data.hotelId));
    res.fold(
        (l) => emit(StateNoData()),
        (r) => emit(StateOnSuccess((state as StateOnSuccess<CustomState>)
            .response
            .copyWith(hotelDetailModel: r))));
  }
}

class CustomState {
  RoomDataPostModel? roomDataPostModel;
  HotelDetailModel? hotelDetailModel;
  CustomState({this.hotelDetailModel, this.roomDataPostModel});
  CustomState copyWith(
      {RoomDataPostModel? roomDataPostModel,
      HotelDetailModel? hotelDetailModel}) {
    return CustomState(
        roomDataPostModel: roomDataPostModel ?? this.roomDataPostModel,
        hotelDetailModel: hotelDetailModel ?? this.hotelDetailModel);
  }

  @override
  List<Object?> get props => [];
}
