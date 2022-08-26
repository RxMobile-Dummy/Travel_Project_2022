import 'package:bloc/bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/failures/failure_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../user/domain/usecases/is_anonymous_user.dart';
import '../../domain/use_cases/search_hotel_use_cases.dart';

class SearchHotelCubit extends Cubit<BaseState> {
  final SearchHotelUseCases searchHotelUseCases;
  final BehaviorSubject<String?> searchData = BehaviorSubject.seeded(null);
  final IsAnonymousUser isAnonymousUser;
  CleanCalendarController? cleanCalendarController;

  int rooms = 1;
  int adults = 1;
  String city = "";
  int searchId = 0;
  String? type;
  var today = DateTime.now();
  DateTime? inTime;
  DateTime? outTime;

  SearchHotelCubit(this.searchHotelUseCases, this.isAnonymousUser)
      : super(StateInitial()) {
    inTime = today;
    outTime = today.add(const Duration(days: 1));
    init();
    searchData
        .debounceTime(const Duration(milliseconds: 500))
        .listen((searchData) {
      getHotelList(searchData);
    });
  }

  init() {
    cleanCalendarController = CleanCalendarController(
        minDate: today,
        maxDate: today.add(const Duration(days: 365)),
        onRangeSelected: (checkInTime, checkOutTime) {
          if (checkOutTime != null) {
            final diff = checkOutTime.difference(checkInTime).inDays;
            if (diff > 30) {
              emit(StateErrorGeneral(
                  "You can book hotel rooms for only 30 days."));
              inTime = checkInTime;
              outTime = null;
              emit(StateOnSuccess(""));
              init();
            } else {
              if (checkInTime == checkOutTime) {
                inTime = checkInTime;
                outTime = null;
                init();
                emit(StateOnSuccess(""));
              } else {
                inTime = checkInTime;
                outTime = checkOutTime;
                emit(StateOnSuccess(""));
              }
            }
          } else {
            inTime = checkInTime;
            outTime = checkOutTime;
            emit(StateOnSuccess(""));
          }
        },
        initialDateSelected: inTime,
        endDateSelected: outTime);
  }

  goToWishlist() async {
    emit(StateInitial());
    final res = await isAnonymousUser.call(NoParams());
    res.fold((failure) {}, (success) {
      if (success) {
        emit(Unauthenticated());
      } else {
        emit(Authenticated());
      }
    });
  }

  void getHotelList(String? places) async {
    if (places != null && places.isNotEmpty) {
      final res = await searchHotelUseCases.call(places);
      res.fold((l) => emit(FailureHandler.checkFailures(l)),
          (r) => emit(StateOnKnownToSuccess(r)));
    } else {
      emit(StateInitial());
    }
  }

  void getSearchInputData(String searchInput) {
    searchData.add(searchInput);
  }

  clearCalender() {
    emit(StateInitial());
    cleanCalendarController!.clearSelectedDates();
    inTime = today;
    outTime = today.add(const Duration(days: 1));
    init();
    emit(StateOnSuccess(""));
  }

  selectRooms(int rooms) {
    emit(StateInitial());
    this.rooms = rooms;
    emit(StateOnSuccess(""));
  }

  selectAdults(int adults) {
    emit(StateInitial());
    this.adults = adults;
    emit(StateOnSuccess(""));
  }

  selectCityName(String cityName, int searchId, String type) {
    emit(StateInitial());
    this.city = cityName;
    this.searchId = searchId;
    this.type = type;
    emit(StateOnSuccess(""));
  }
}
