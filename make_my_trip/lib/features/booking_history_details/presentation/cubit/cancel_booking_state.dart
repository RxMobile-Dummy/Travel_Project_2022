part of 'cancel_booking_cubit.dart';

abstract class CancelBookingState extends Equatable {
  const CancelBookingState();
}

class CancelBookingInitial extends CancelBookingState {
  @override
  List<Object> get props => [];

}
class BookingsCancelled extends CancelBookingState{
  @override
  List<Object> get props => [];

}
class BookingsCancellationFailure extends CancelBookingState{
  @override
  List<Object> get props => [];

}
