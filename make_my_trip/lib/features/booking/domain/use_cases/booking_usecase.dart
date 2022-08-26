import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/booking/data/model/booking_model.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/booking_repository.dart';

class BookingUseCase implements Usecase<BookingModel, BookingParams> {
  final BookingRepository bookingRepository;
  BookingUseCase(this.bookingRepository);

  @override
  Future<Either<Failures, BookingModel>> call(BookingParams params) async {
    return await bookingRepository.getBookingDetails(params.hotelId, params.cIn,
        params.cOut, params.roomId, params.adults, params.coupon_id);
  }
}

class BookingParams {
  final int hotelId;
  final String cIn;
  final String cOut;
  final List<int> roomId;
  final int adults;
  final int coupon_id;
  BookingParams(this.hotelId, this.cIn, this.cOut, this.roomId, this.adults,
      this.coupon_id);

  @override
  List<Object?> get props => [hotelId, cIn, cOut, roomId];
}
