abstract class SearchHotelState {}

class SearchHotelInitial extends SearchHotelState {}

class DateSelectState extends SearchHotelState {}

class ErrorState extends SearchHotelState {
  final String error;
  ErrorState({required this.error});
}

class NoOfRooms extends SearchHotelState {}

class UninitializedState extends SearchHotelState {}

class AuthenticatedState extends SearchHotelState {}

class UnauthenticatedState extends SearchHotelState {}

class StateNoDataState extends SearchHotelState {}

class StateOnKnownToSuccessState<T> extends SearchHotelState {
  final T response;
  StateOnKnownToSuccessState(this.response);
}
