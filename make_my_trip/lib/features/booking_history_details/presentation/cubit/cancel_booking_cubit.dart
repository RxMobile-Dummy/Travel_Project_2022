import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:make_my_trip/features/booking_history_details/domain/use_cases/user_history_detail_usecase.dart';
import 'package:make_my_trip/features/user_history/domain/use_cases/user_history_usecase.dart';

import '../../../../core/base/base_state.dart';
import '../../../../utils/constants/base_constants.dart';

part 'cancel_booking_state.dart';

class CancelBookingCubit extends Cubit<CancelBookingState> {
  UserHistoryDetailUseCase userHistoryDetailUseCase;
  CancelBookingCubit(this.userHistoryDetailUseCase)
      : super(CancelBookingInitial());
  cancelBooking(int? bookingId) async {
    try {
      final response = await userHistoryDetailUseCase.call(bookingId);
      response.fold((l) => emit(BookingsCancellationFailure()),
          (r) => emit(BookingsCancelled()));
    } catch (e) {
      emit(BookingsCancellationFailure());
    }
  }
}
