import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';

import 'calender_state.dart';

class CalenderCubit extends Cubit<CalenderState> {
  CleanCalendarController? cleanCalendarController;

  int rooms = 1;
  int adults = 1;
  int childrens = 0;
  DateTime? inTime = DateTime.now();
  DateTime? outTime = DateTime.now().add(const Duration(days: 1));

  CalenderCubit() : super(CalenderInitial());
  init() {
    cleanCalendarController = CleanCalendarController(
        minDate: DateTime.now(),
        maxDate: DateTime.now().add(const Duration(days: 365)),
        onRangeSelected: (checkInTime, checkOutTime) {
          if (checkOutTime != null) {
            final diff = checkOutTime.difference(checkInTime).inDays;
            if (diff > 30) {
              emit(ErrorState(
                  error: "You can book hotel rooms for only 30 days."));
              inTime = checkInTime;
              outTime = null;
              emit(DateSelectState());
            } else {
              if (checkInTime == checkOutTime) {
                inTime = checkInTime;
                outTime = null;
                emit(DateSelectState());
              } else {
                inTime = checkInTime;
                outTime = checkOutTime;
                emit(DateSelectState());
              }
            }
          } else {
            inTime = checkInTime;
            outTime = checkOutTime;
            emit(DateSelectState());
          }
        },
        initialDateSelected: inTime,
        endDateSelected: outTime);
  }

  clearCalender() {
    cleanCalendarController!.clearSelectedDates();
    inTime = DateTime.now();
    outTime = DateTime.now().add(Duration(days: 1));
    emit(DateSelectState());
  }

  selectRooms(int rooms) {
    this.rooms = rooms;
    emit(NoOfRooms());
  }

  selectAdults(int adults) {
    this.adults = adults;
    emit(NoOfRooms());
  }

  selectChildrens(int childrens) {
    this.childrens = childrens;
    emit(NoOfRooms());
  }
}
