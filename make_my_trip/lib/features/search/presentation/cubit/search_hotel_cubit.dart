import 'package:bloc/bloc.dart';
import 'package:make_my_trip/features/search/presentation/cubit/search_hotel_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../user/domain/usecases/is_anonymous_user.dart';
import '../../domain/use_cases/search_hotel_use_cases.dart';

class SearchHotelCubit extends Cubit<SearchHotelState> {
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
      : super(SearchHotelInitial()) {
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
              emit(ErrorState(
                  error: "You can book hotel rooms for only 30 days."));
              inTime = checkInTime;
              outTime = null;
              emit(DateSelectState());
              init();
            } else {
              if (checkInTime == checkOutTime) {
                inTime = checkInTime;
                outTime = null;
                init();
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

  goToWishlist() async {
    emit(SearchHotelInitial());
    final res = await isAnonymousUser.call(NoParams());
    res.fold((failure) {}, (success) {
      if (success) {
        emit(UnauthenticatedState());
      } else {
        emit(AuthenticatedState());
      }
    });
  }

  void getHotelList(String? places) async {
    if (places != null && places.isNotEmpty) {
      final res = await searchHotelUseCases.call(places);
      res.fold((l) => emit(ErrorState(error: "Something went wrong!!")),
          (r) => emit(StateOnKnownToSuccessState(r)));
    } else {
      emit(SearchHotelInitial());
    }
  }

  void getSearchInputData(String searchInput) {
    searchData.add(searchInput);
  }

  clearCalender() {
    emit(SearchHotelInitial());
    cleanCalendarController!.clearSelectedDates();
    inTime = today;
    outTime = today.add(const Duration(days: 1));
    init();
    emit(DateSelectState());
  }

  selectRooms(int rooms) {
    emit(SearchHotelInitial());
    this.rooms = rooms;
    emit(NoOfRooms());
  }

  selectAdults(int adults) {
    emit(SearchHotelInitial());
    this.adults = adults;
    emit(NoOfRooms());
  }

  selectCityName(String cityName, int searchId, String type) {
    emit(SearchHotelInitial());
    this.city = cityName;
    this.searchId = searchId;
    this.type = type;
    emit(CityNameState());
  }
}
