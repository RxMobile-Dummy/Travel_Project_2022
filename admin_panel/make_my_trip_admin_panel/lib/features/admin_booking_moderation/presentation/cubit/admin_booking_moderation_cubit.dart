import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/data/models/booking_moderation_model.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/domain/use_cases/admin_booking_moderation_use_cases.dart';

class AdminBookingModerationCubit extends Cubit<BaseState> {
  AdminBookingModerationCubit(this.adminBookingModerationUseCases)
      : super(StateInitial());

  final AdminBookingModerationUseCases adminBookingModerationUseCases;
  int defaultPage = -1;
  List<BookingModerationModel> bookingList = [];
  List<BookingModerationModel> filterList = [];

  getAllBookingListEvent(
      {int? page,
      String? userName,
      String? hotelName,
      String? checkInDateValue,
      String? checkOutDateValue,
      bool? filter}) async {
    if (filter == true) {
      if (userName == "" &&
          hotelName == "" &&
          checkInDateValue == DateTime.now().toString().substring(0, 10) &&
          checkOutDateValue == "") {
      } else {
        resetFilterEvent(filter!);
      }
    }
    filterList = [];
    if (state is! StateOnSuccess) {
      emit(StateLoading());
    } else {
      filterList = bookingList;
      emit(StateOnSuccess<List<BookingModerationModel>>(filterList,
          isMoreLoading: true));
    }
    defaultPage = page ?? ++defaultPage;
    final res = await adminBookingModerationUseCases.call(FilterParams(
        page: defaultPage,
        checkInDate: checkInDateValue,
        checkOutDate: checkOutDateValue,
        hotelname: hotelName,
        username: userName));
    res.fold((l) => emit(StateErrorGeneral(l.toString())), (r) {
      if (page == null) {
        for (var item in r) {
          bookingList.add(item);
        }
        filterList = bookingList;
      } else {
        filterList = r;
      }
      if (filterList.isEmpty) {
        emit(StateNoData());
      } else {
        emit(StateOnSuccess<List<BookingModerationModel>>(filterList,
            isMoreLoading: false));
      }
    });
  }

  void setUpScrollController(ScrollController scrollController,
      {String? userName,
      String? hotelName,
      String? checkInDateVal,
      String? checkOutDateVal}) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          getAllBookingListEvent();
        }
      }
    });
  }

  void searchList(String searchKeyWord) {
    emit(StateLoading());
    filterList = [];
    for (var item in bookingList) {
      if (item.userdata![0].userName!
              .toLowerCase()
              .contains(searchKeyWord.toLowerCase()) ||
          item.hoteldata![0].hotelName!
              .toLowerCase()
              .contains(searchKeyWord.toLowerCase())) {
        filterList.add(item);
      }
    }
    if (filterList.isEmpty) {
      emit(StateNoData());
    } else {
      emit(StateOnSuccess(filterList, isMoreLoading: false));
    }
  }

  void resetFilterEvent(bool resetValue) {
    emit(StateOnKnownToSuccess(resetValue));
  }
}
