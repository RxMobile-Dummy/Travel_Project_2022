import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/hotel_listing/data/models/hotel_list_model.dart';
import 'package:make_my_trip/features/hotel_listing/domain/use_cases/hotel_list_usecase.dart';

class HotelListCubit extends Cubit<BaseState> {
  HotelListCubit({required this.hotelListUsecase}) : super(StateInitial());
  final HotelListUsecase hotelListUsecase;

  getHotelListApi(String hotelName) async {
    var hotelListData = await hotelListUsecase.call(Params(hotelName));
    hotelListData.fold((l) => emit(StateErrorGeneral("errorMessage")),
        (r) => emit(StateOnSuccess<List<HotelListModel>>(r)));
  }
}
