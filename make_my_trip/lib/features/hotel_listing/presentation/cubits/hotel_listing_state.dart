part of 'hotel_listing_cubit.dart';

abstract class HotelListingState extends Equatable {
  const HotelListingState();
}

class HotelListingInitial extends HotelListingState {
  @override
  List<Object> get props => [];
}

class HotelListingLoading extends HotelListingState {
  @override
  List<Object> get props => [];
}

class HotelListingLoaded extends HotelListingState {
  @override
  List<Object> get props => [];
}

class HotelListingFailure extends HotelListingState {
  @override
  List<Object> get props => [];
}
