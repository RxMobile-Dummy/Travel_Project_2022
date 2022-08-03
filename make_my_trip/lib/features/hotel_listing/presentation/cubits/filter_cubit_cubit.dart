import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/hotel_listing/data/models/hotel_list_model.dart';
import 'package:make_my_trip/features/hotel_listing/domain/use_cases/hotel_list_usecase.dart';
import 'package:make_my_trip/utils/extensions/common/common_extensions.dart';

class FilterCubit extends Cubit<BaseState> {
  FilterCubit() : super(StateInitial());

  final Set selectedRating = {};
  final Set selectedAmenities = {};
  String price = "";
  final Set selectedFilter = {};

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
      print(filter);
      print(price);
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
}
