import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectRoomCountCubit extends Cubit<SelectRoomCountState> {
  SelectRoomCountCubit()
      : super(const SelectRoomCountState(
            superDeluxReadMore: false,
            deluxReadMore: false,
            semiDeluxReadMore: false,
            superDeluxValue: 0,
            deluxValue: 0,
            semiDeluxValue: 0));

  onReadMoreTap(bool isReadMore, String roomType) {
    if (roomType == 'Delux') {
      print("4");
      emit(state.copyWith(deluxReadMore: !isReadMore));
    } else if (roomType == 'SemiDelux') {
      emit(state.copyWith(semiDeluxReadMore: !isReadMore));
    } else if (roomType == "SuperDelux") {
      emit(state.copyWith(superDeluxReadMore: !isReadMore));
    }
  }

  void addRoomEvent(String roomType, int addRoomValue) {
    if (roomType == 'Delux') {
      print("5");
      emit(state.copyWith(deluxValue: addRoomValue + 1));
    } else if (roomType == 'SemiDelux') {
      emit(state.copyWith(semiDeluxValue: addRoomValue + 1));
    } else if (roomType == "SuperDelux") {
      emit(state.copyWith(superDeluxValue: addRoomValue + 1));
    }
  }

  void removeRoomEvent(String roomType, int removeRoomValue) {
    if (removeRoomValue > 0) {

      if (roomType == 'Delux') {
        print("6");
        emit(state.copyWith(deluxValue: removeRoomValue - 1));
      } else if (roomType == 'SemiDelux') {
        emit(state.copyWith(semiDeluxValue: removeRoomValue - 1));
      } else if (roomType == "SuperDelux") {
        emit(state.copyWith(superDeluxValue: removeRoomValue - 1));
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
          {int? superDeluxValue = 0,
          int? deluxValue = 0,
          int? semiDeluxValue = 0,
          bool? superDeluxReadMore = false,
          bool? semiDeluxReadMore = false,
          bool? deluxReadMore = false}) =>
      SelectRoomCountState(
          superDeluxReadMore: superDeluxReadMore ?? this.superDeluxReadMore,
          semiDeluxReadMore: semiDeluxReadMore ?? this.semiDeluxReadMore,
          deluxReadMore: deluxReadMore ?? this.deluxReadMore,
          superDeluxValue: superDeluxValue ?? this.superDeluxValue,
          deluxValue: deluxValue ?? this.deluxValue,
          semiDeluxValue: semiDeluxValue ?? this.semiDeluxValue);

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
