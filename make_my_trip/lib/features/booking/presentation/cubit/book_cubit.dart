import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/hotel_detail/data/model/hotel_detail_model.dart';
import 'package:make_my_trip/features/hotel_detail/domain/use_cases/hotel_detail_usecase.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';
import 'package:make_my_trip/features/room_categories/domain/use_cases/room_book_post_usecase.dart';

class BookingCubit extends Cubit<BaseState> {
  BookingCubit(this.roomBookPostUsecase,this.hotelDetailUseCase) : super(StateInitial());

  RoomBookPostUsecase roomBookPostUsecase;
  HotelDetailUseCase hotelDetailUseCase;

  roomBookPost(int hotelId,RoomDataPostModel roomDataPostModel)async {
    var res = await roomBookPostUsecase.call(RoomBookParams(hotelId,roomDataPostModel));
    res.fold((l) => {print(l)}, (r) => {print(r)});
  }

  getHotelDetailData(int data) async {
    emit(StateLoading());
    final res = await hotelDetailUseCase.call(HotelDetailParams(index: data));
    res.fold((l) => emit(StateNoData()),
            (r) => emit(StateOnKnownToSuccess<HotelDetailModel>(r)));
  }


}