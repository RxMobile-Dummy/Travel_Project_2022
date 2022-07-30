abstract class CalenderState {}

class CalenderInitial extends CalenderState {}

class DateSelectState extends CalenderState {}

class ErrorState extends CalenderState {
  final String error;

  ErrorState({required this.error});
}

class NoOfRooms extends CalenderState {}
