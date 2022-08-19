import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import '../../../user/domain/usecases/is_anonymous_user.dart';

class SelectRoomCountCubit extends Cubit<BaseState> {
  SelectRoomCountCubit(this.isAnonymousUser)
      : super(StateOnSuccess<SelectRoomCountState>(const SelectRoomCountState(
          deluxValue: 0,
          semiDeluxValue: 0,
          superDeluxValue: 0,
          totalRooms: 0,
        )));

  final IsAnonymousUser isAnonymousUser;

  void addRoomEvent(
      String roomType, int addRoomValue, int maxRoomCount, int userMaxCount) {
    if (addRoomValue < maxRoomCount &&
        addRoomValue < userMaxCount &&
        (state as StateOnSuccess<SelectRoomCountState>).response.totalRooms <
            userMaxCount) {
      if (roomType == 'Deluxe') {
        emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
            .response
            .copyWith(
                deluxValue: addRoomValue + 1,
                totalRooms: (state as StateOnSuccess<SelectRoomCountState>)
                        .response
                        .totalRooms +
                    1)));
      } else if (roomType == 'Semi-Deluxe') {
        emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
            .response
            .copyWith(
                semiDeluxValue: addRoomValue + 1,
                totalRooms: (state as StateOnSuccess<SelectRoomCountState>)
                        .response
                        .totalRooms +
                    1)));
      } else if (roomType == "Super-Deluxe") {
        emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
            .response
            .copyWith(
                superDeluxValue: addRoomValue + 1,
                totalRooms: (state as StateOnSuccess<SelectRoomCountState>)
                        .response
                        .totalRooms +
                    1)));
      }
    }
  }

  void removeRoomEvent(String roomType, int removeRoomValue, int userMaxCount) {
    if (removeRoomValue > 0) {
      if (roomType == 'Deluxe') {
        emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
            .response
            .copyWith(
                deluxValue: removeRoomValue - 1,
                totalRooms: (state as StateOnSuccess<SelectRoomCountState>)
                        .response
                        .totalRooms -
                    1)));
      } else if (roomType == 'Semi-Deluxe') {
        emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
            .response
            .copyWith(
                semiDeluxValue: removeRoomValue - 1,
                totalRooms: (state as StateOnSuccess<SelectRoomCountState>)
                        .response
                        .totalRooms -
                    1)));
      } else if (roomType == "Super-Deluxe") {
        emit(StateOnSuccess((state as StateOnSuccess<SelectRoomCountState>)
            .response
            .copyWith(
                superDeluxValue: removeRoomValue - 1,
                totalRooms: (state as StateOnSuccess<SelectRoomCountState>)
                        .response
                        .totalRooms -
                    1)));
      }
    }
  }
}

class SelectRoomCountState extends Equatable {
  final int superDeluxValue;
  final int deluxValue;
  final int semiDeluxValue;
  final int totalRooms;

  const SelectRoomCountState({
    required this.totalRooms,
    required this.superDeluxValue,
    required this.deluxValue,
    required this.semiDeluxValue,
  });

  SelectRoomCountState copyWith(
          {int? superDeluxValue,
          bool? checkExtraMetresses,
          int? deluxValue,
          int? semiDeluxValue,
          int? totalRooms,
          int? extraMetresses}) =>
      SelectRoomCountState(
        totalRooms: totalRooms ?? this.totalRooms,
        superDeluxValue: superDeluxValue ?? this.superDeluxValue,
        deluxValue: deluxValue ?? this.deluxValue,
        semiDeluxValue: semiDeluxValue ?? this.semiDeluxValue,
      );

  @override
  List<Object?> get props => [
        superDeluxValue,
        deluxValue,
        semiDeluxValue,
        totalRooms,
      ];
}
