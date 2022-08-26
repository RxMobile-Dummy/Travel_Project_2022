import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/hotel_listing/data/models/hotel_list_model.dart';
import 'package:make_my_trip/features/hotel_listing/domain/use_cases/hotel_list_usecase.dart';
import 'package:make_my_trip/utils/extensions/common/common_extensions.dart';

class HotelListCubit extends Cubit<BaseState> {
  HotelListCubit({required this.hotelListUsecase}) : super(StateInitial());
  final HotelListUsecase hotelListUsecase;

  final Set selectedRating = {};
  final Set selectedAmenities = {};
  String price = "";
  final Set selectedFilter = {};
  int page = 0;
  List<HotelListModel> hotelList = [];

  resetFilters() {
    emit(Uninitialized());
    selectedRating.clear();
    selectedAmenities.clear();
    price = "";
    selectedFilter.clear();
    emit(StateOnResponseSuccess<Set>(selectedFilter));
  }

  selectFilter(filter, type) {
    selectedFilter.clear();
    emit(Uninitialized());
    if (type == "Amenities") {
      _contains(selectedAmenities, filter);
    } else if (type == "Rating") {
      _contains(selectedRating, filter);
    } else if (type == "Price Range") {
      if (filter == price) {
        price = "";
      } else {
        price = filter;
      }
    }
    selectedFilter.addAll(selectedRating);
    selectedFilter.addAll(selectedAmenities);
    (price == "") ? selectedFilter.remove(price) : selectedFilter.add(price);
    emit(StateOnResponseSuccess<Set>(selectedFilter));
  }

  _contains(list, filter) {
    if (list.contains(filter)) {
      list.remove(filter);
    } else {
      list.add(filter);
    }
    return list;
  }

  getHotelListApi(
    cin,
    cout,
    noOfRoom,
    searchId,
    type,
  ) async {
    Params params;
    if (selectedFilter.isNotEmpty) {
      String aminities = selectedAmenities.join(",");
      String finalPrice = price.changePriceApi();
      String ratings = selectedRating.join(",");
      params = Params(
        cin: cin,
        cout: cout,
        noOfRoom: noOfRoom,
        id: searchId,
        type: type,
        aminities: aminities,
        price: finalPrice,
        rating: ratings,
        pagesize: 3,
        page: page,
      );
    } else {
      params = Params(
        cin: cin,
        cout: cout,
        noOfRoom: noOfRoom,
        id: searchId,
        type: type,
        pagesize: 3,
        page: page,
      );
    }

    if (state is! StateOnSuccess) {
      emit(StateLoading());
    } else {
      emit(
          StateOnSuccess<List<HotelListModel>>(hotelList, isMoreLoading: true));
    }
    page++;
    final res = await hotelListUsecase.call(params);
    res.fold((l) {
      emit(StateErrorGeneral("errorMessage"));
    }, (r) {
      for (var item in r) {
        hotelList.add(item);
      }
      emit(StateOnSuccess<List<HotelListModel>>(hotelList,
          isMoreLoading: false));
    });
  }

  void setUpScrollController(
      ScrollController scrollController, cin, cout, noOfRoom, id, type) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          getHotelListApi(cin, cout, noOfRoom, id, type);
        }
      }
    });
  }
}
