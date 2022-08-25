import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/data/models/booking_moderation_model.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/domain/use_cases/admin_booking_moderation_use_cases.dart';

class AdminBookingModerationCubit extends Cubit<BaseState> {
  AdminBookingModerationCubit(this.adminBookingModerationUseCases)
      : super(StateInitial());
  final AdminBookingModerationUseCases adminBookingModerationUseCases;
  int page = -1;
  List<BookingModerationModel> bookingList = [];

  getAllBookingListEvent(date1, date2, hotelname, username) async {
    if (state is! StateOnSuccess) {
      emit(StateLoading());
    } else {
      emit(StateOnSuccess<List<BookingModerationModel>>(bookingList,
          isMoreLoading: true));
    }
    page++;
    final res = await adminBookingModerationUseCases.call(FilterParams(
        page: page,
        date1: date1,
        date2: date2,
        hotelname: hotelname,
        username: username));
    res.fold((l) => StateError(l.toString()), (r) {
      for (var item in r) {
        bookingList.add(item);
      }
      emit(StateOnSuccess<List<BookingModerationModel>>(bookingList,
          isMoreLoading: false));
    });
  }

  void setUpScrollController(
      ScrollController scrollController, date1, date2, hotelname, username) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          getAllBookingListEvent(date1, date2, hotelname, username);
        }
      }
    });
  }
}