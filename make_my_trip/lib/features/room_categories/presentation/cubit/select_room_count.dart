import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';

class SelectRoomCountCubit extends Cubit<BaseState> {
  SelectRoomCountCubit()
      : super(StateOnSuccess<SelectRoomCountState>(SelectRoomCountState(
            superDeluxReadMore: false,
            deluxReadMore: false,
            deluxValue: 1,
            semiDeluxReadMore: false,
            semiDeluxValue: 1,
            superDeluxValue: 1)));

  onReadMoreTap(bool isReadMore, String roomType) {
    print('print cubit');
    if (roomType == 'Deluxe') {
      print("4");
      emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
          .response
          .copyWith(deluxReadMore: !isReadMore)));
    } else if (roomType == 'Semi-Deluxe') {
      emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
          .response
          .copyWith(semiDeluxReadMore: !isReadMore)));
    } else if (roomType == "Super-Deluxe") {
      print('dfiods');

      emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
          .response
          .copyWith(superDeluxReadMore: !isReadMore)));
    }
  }

  void addRoomEvent(String roomType, int addRoomValue,int maxRoomCount) {
    if(addRoomValue<maxRoomCount) {
      if (roomType == 'Deluxe') {
        print("5");

        emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
            .response
            .copyWith(deluxValue: addRoomValue + 1)));
      } else if (roomType == 'Semi-Deluxe') {
        emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
            .response
            .copyWith(semiDeluxValue: addRoomValue + 1)));
      } else if (roomType == "Super-Deluxe") {
        emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
            .response
            .copyWith(superDeluxValue: addRoomValue + 1)));
      }
    }
  }

  void removeRoomEvent(String roomType, int removeRoomValue) {
    print('cubit');
    if (removeRoomValue > 1) {
      if (roomType == 'Deluxe') {
        print("6");
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
}

class SelectRoomCountState extends Equatable {
  final int superDeluxValue;
  final int deluxValue;
  final int semiDeluxValue;
  final bool superDeluxReadMore;
  final bool deluxReadMore;
  final bool semiDeluxReadMore;


  const SelectRoomCountState({
    required this.superDeluxReadMore,
    required this.deluxReadMore,
    required this.semiDeluxReadMore,
    required this.superDeluxValue,
    required this.deluxValue,
    required this.semiDeluxValue,

  });

  SelectRoomCountState copyWith(
          {int? superDeluxValue = 1,
          int? deluxValue = 1,
          int? semiDeluxValue = 1,
          bool? superDeluxReadMore = false,
          bool? semiDeluxReadMore = false,
          bool? deluxReadMore = false,
           }) =>
      SelectRoomCountState(
          superDeluxReadMore: superDeluxReadMore ?? this.superDeluxReadMore,
          semiDeluxReadMore: semiDeluxReadMore ?? this.semiDeluxReadMore,
          deluxReadMore: deluxReadMore ?? this.deluxReadMore,
          superDeluxValue: superDeluxValue ?? this.superDeluxValue,
          deluxValue: deluxValue ?? this.deluxValue,
          semiDeluxValue: semiDeluxValue ?? this.semiDeluxValue,);

  @override
  List<Object?> get props => [
        superDeluxValue,
        deluxValue,
        semiDeluxValue,
        superDeluxReadMore,
        semiDeluxReadMore,
        deluxReadMore,
      ];
}
