import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/room_categories/domain/use_cases/room_categories_usecase.dart';

class RoomCategoryCubit extends Cubit<BaseState> {
  RoomCategoryCubit(this.roomCategoriesUseCase)
      : super(StateInitial()) {
    getData(3);
  }

  final RoomCategoriesUseCase roomCategoriesUseCase;

  getData(int hotelId) async {
    var res = await roomCategoriesUseCase.call(Params(hotelId));
    res.fold((l) => {print(l)},
        (r) => emit(StateOnKnownToSuccess(r)));
  }

  onReadMoreTap(bool isReadMore) {
    emit(StateOnSuccess<bool>(!isReadMore));
  }

  void addRoomEvent(String roomType, int addRoomValue) {
    if (roomType == 'Delux') {
      emit(StateOnKnownToSuccess(
          (state as StateOnKnownToSuccess<SelectRoomCountState>)
              .response
              .copyWith(deluxValue: addRoomValue + 1)));
    } else if (roomType == 'SemiDelux') {
      emit(StateOnKnownToSuccess(
          (state as StateOnKnownToSuccess<SelectRoomCountState>)
              .response
              .copyWith(semiDeluxValue: addRoomValue + 1)));
    } else {
      emit(StateOnKnownToSuccess(
          (state as StateOnKnownToSuccess<SelectRoomCountState>)
              .response
              .copyWith(superDeluxValue: addRoomValue + 1)));
    }
  }

  void removeRoomEvent(String roomType, int removeRoomValue) {
    if (removeRoomValue > 0) {
      if (roomType == 'Delux') {
        emit(StateOnKnownToSuccess(
            (state as StateOnKnownToSuccess<SelectRoomCountState>)
                .response
                .copyWith(deluxValue: removeRoomValue - 1)));
      } else if (roomType == 'SemiDelux') {
        emit(StateOnKnownToSuccess(
            (state as StateOnKnownToSuccess<SelectRoomCountState>)
                .response
                .copyWith(semiDeluxValue: removeRoomValue - 1)));
      } else {
        emit(StateOnKnownToSuccess(
            (state as StateOnKnownToSuccess<SelectRoomCountState>)
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

  const SelectRoomCountState({
    required this.superDeluxValue,
    required this.deluxValue,
    required this.semiDeluxValue,
  });

  SelectRoomCountState copyWith({
    int? superDeluxValue,
    int? deluxValue,
    int? semiDeluxValue,
  }) =>
      SelectRoomCountState(
        superDeluxValue: superDeluxValue ?? this.superDeluxValue,
        deluxValue: deluxValue ?? this.deluxValue,
        semiDeluxValue: semiDeluxValue ?? this.semiDeluxValue,
      );

  @override
  List<Object?> get props => [
        superDeluxValue,
        deluxValue,
        semiDeluxValue,
      ];
}
