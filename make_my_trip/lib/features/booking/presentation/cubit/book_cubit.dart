import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/hotel_detail/data/model/hotel_detail_model.dart';
import 'package:make_my_trip/features/hotel_detail/domain/use_cases/hotel_detail_usecase.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_categories_model.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';
import 'package:make_my_trip/features/room_categories/domain/use_cases/room_book_post_usecase.dart';

class BookingCubit extends Cubit<BaseState> {
  BookingCubit(this.roomBookPostUsecase,this.hotelDetailUseCase) : super(StateOnSuccess<CustomState>(CustomState()));

  RoomBookPostUsecase roomBookPostUsecase;
  HotelDetailUseCase hotelDetailUseCase;

  roomBookPost(int hotelId,RoomDataPostModel roomDataPostModel)async {
    var res = await roomBookPostUsecase.call(RoomBookParams(hotelId,roomDataPostModel));
    res.fold((l) => {emit(StateErrorGeneral(l.toString()))}, (r) => {emit(StateOnKnownToSuccess(r))});
  }

  getHotelDetailData(data) async {
    final res = await hotelDetailUseCase.call(HotelDetailParams(index: data.hotelId));
    res.fold((l) => emit(StateNoData()),
            (r) => emit(StateOnSuccess((state as StateOnSuccess<CustomState>)
                .response
                .copyWith(hotelDetailModel: r))));
  }


  postModelCreate(int hotelId,String cin,String cout,int noOfRoom,List<RoomType> roomType){
    var dateCin=DateTime.parse(cin);
    var dateCout=DateTime.parse(cout);
    var noOfNights=dateCout.difference(dateCin). inDays;
    List<int> roomId = [];
    for(var i=0;i<noOfRoom;i++){
      if(roomType[i].roomId!=null) {
        roomId.add(roomType[i].roomId!);
      }
    }
    Price p=Price(
      numberOfNights:noOfNights,
      roomPrice:((roomType[0].price ?? 1)*noOfRoom).toDouble(),
      gst: (((roomType[0].price ?? 1)*noOfRoom) * 0.18),
      discount:5,
      totalPrice:500,
    );
    RoomDataPostModel roomDataPostModel=RoomDataPostModel(
        hotelId:hotelId,
        checkinDate:cin,
        checkoutDate:cout,
        noOfRoom:noOfRoom,
        roomType: roomType[0].roomType,
        price:p,
        roomId: roomId
    );
    emit(StateOnSuccess((state as StateOnSuccess<CustomState>)
        .response
        .copyWith(roomDataPostModel: roomDataPostModel)));
  }

}
class CustomState {
  RoomDataPostModel? roomDataPostModel;
  HotelDetailModel? hotelDetailModel;
  CustomState({ this.hotelDetailModel, this.roomDataPostModel});
  CustomState copyWith({
    RoomDataPostModel? roomDataPostModel,
    HotelDetailModel? hotelDetailModel
  }) {
    return CustomState(
        roomDataPostModel:  roomDataPostModel ?? this.roomDataPostModel,
        hotelDetailModel: hotelDetailModel ?? this.hotelDetailModel
    );
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}