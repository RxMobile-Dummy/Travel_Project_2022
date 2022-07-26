import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_categories_model.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';

class SelectRoomCountCubit extends Cubit<BaseState> {
  SelectRoomCountCubit()
      : super(StateOnSuccess<SelectRoomCountState>(SelectRoomCountState(
      deluxValue: 0,
      semiDeluxValue: 0,
      superDeluxValue: 0)));


  void addRoomEvent(String roomType, int addRoomValue,int maxRoomCount) {
    if(addRoomValue<maxRoomCount) {
      if (roomType == 'Deluxe') {
        emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
            .response
            .copyWith(deluxValue: addRoomValue + 1)));
      } else if (roomType == 'Semi-Deluxe') {
        emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
            .response
            .copyWith(semiDeluxValue: addRoomValue + 1)));
      } else if (roomType == "Super-Deluxe") {
        print('super');
        emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
            .response
            .copyWith(superDeluxValue: addRoomValue + 1)));
      }
    }
  }

  void removeRoomEvent(String roomType, int removeRoomValue) {

    if (removeRoomValue > 0) {
      if (roomType == 'Deluxe') {

        emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
            .response
            .copyWith(deluxValue: removeRoomValue - 1)));
      } else if (roomType == 'Semi-Deluxe') {
        emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
            .response
            .copyWith(semiDeluxValue: removeRoomValue - 1)));
      } else if (roomType == "Super-Deluxe") {
        emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
            .response
            .copyWith(superDeluxValue: removeRoomValue - 1)));
      }
    }
  }
  postModelCreate(int hotelId,String cin,String cout,int noOfRoom,List<RoomType> roomType){
    List<int> roomId = [];
    for(var i=0;i<noOfRoom;i++){
      if(roomType[i].roomId!=null) {
        roomId.add(roomType[i].roomId!);
      }
    }
    Price p=Price(
      numberOfNights:1,
      roomPrice:2,
      gst:2,
      discount:5,
      totalPrice:500,
    );
    RoomDataPostModel roomDataPostModel=RoomDataPostModel(
        hotelId:hotelId,
        checkinDate:cin,
        checkoutDate:cout,
        noOfRoom:noOfRoom,
        price:p,
        roomId: roomId
    );
    print(roomDataPostModel.roomId);
    emit(StateOnKnownToSuccess<RoomDataPostModel>(roomDataPostModel));
  }
}

class SelectRoomCountState extends Equatable {
  final int superDeluxValue;
  final int deluxValue;
  final int semiDeluxValue;

  const SelectRoomCountState({
    required this.superDeluxValue,
    required this.deluxValue,
    required this.semiDeluxValue,
  });

  SelectRoomCountState copyWith(
      {int? superDeluxValue = 0,
        int? deluxValue = 0,
        int? semiDeluxValue = 0,
      }) =>
      SelectRoomCountState(

        superDeluxValue: superDeluxValue ?? this.superDeluxValue,
        deluxValue: deluxValue ?? this.deluxValue,
        semiDeluxValue: semiDeluxValue ?? this.semiDeluxValue,);

  @override
  List<Object?> get props => [
    superDeluxValue,
    deluxValue,
    semiDeluxValue,];
}