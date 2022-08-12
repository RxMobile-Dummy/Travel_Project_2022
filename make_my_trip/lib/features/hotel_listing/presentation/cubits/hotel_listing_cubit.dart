import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'hotel_listing_state.dart';

class HotelListingCubit extends Cubit<HotelListingState> {
  HotelListingCubit() : super(HotelListingInitial()) {
    _init();
  }

  void _init() {
    emit(HotelListingLoading());
    Future.delayed(const Duration(seconds: 2))
        .then((value) => emit(HotelListingLoaded()));
  }
}
