import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../user/domain/usecases/is_anonymous_user.dart';
import '../../domain/use_cases/search_hotel_use_cases.dart';

class SearchHotelCubit extends Cubit<BaseState> {
  final SearchHotelUseCases searchHotelUseCases;
  final BehaviorSubject<String?> searchData = BehaviorSubject.seeded(null);
  final IsAnonymousUser isAnonymousUser;

  SearchHotelCubit(this.searchHotelUseCases, this.isAnonymousUser)
      : super(StateInitial()) {
    searchData
        .debounceTime(const Duration(milliseconds: 500))
        .listen((searchData) {
      getHotelList(searchData);
    });
  }

  goToWishlist() async {
    emit(Uninitialized());
    final res = await isAnonymousUser.call(NoParams());
    res.fold((failure) {
      print(failure);
    }, (success) {
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
      res.fold(
          (l) => emit(StateNoData()), (r) => emit(StateOnKnownToSuccess(r)));
    }
  }

  void getSearchInputData(String searchInput) {
    searchData.add(searchInput);
  }
}
