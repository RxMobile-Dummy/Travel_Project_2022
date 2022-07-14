import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';

import 'calender_state.dart';

class CalenderCubit extends Cubit<CalenderState> {
  CleanCalendarController? cleanCalendarController;

  String rooms = "1";
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

  selectRoom(String rooms) {
    this.rooms = rooms;
    emit(NoOfRooms());
  }
}
