import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/base/base_state.dart';
import '../../domain/use_cases/search_hotel_use_cases.dart';

class SearchHotelCubit extends Cubit<BaseState> {
  final SearchHotelUseCases searchHotelUseCases;
  final BehaviorSubject<String?> searchData = BehaviorSubject.seeded(null);

  SearchHotelCubit(this.searchHotelUseCases) : super(StateInitial()) {
    searchData
        .debounceTime(const Duration(milliseconds: 500))
        .listen((searchData) {
      getHotelList(searchData);
    });
  }

  void getHotelList(String? places) async {
    if (places != null && places.isNotEmpty) {
      final res = await searchHotelUseCases.call(places);
      res.fold(
          (l) => emit(StateNoData()), (r) => emit(StateOnKnownToSuccess(r)));
    }
  }

  void getSearchInputData(String searchInput) {
    searchData.add(searchInput);
  }
}
