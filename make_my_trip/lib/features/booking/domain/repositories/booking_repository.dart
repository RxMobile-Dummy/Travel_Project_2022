import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/booking/data/model/booking_model.dart';
import 'package:make_my_trip/features/booking/data/model/payment_model.dart';

import '../../../../core/failures/failures.dart';

abstract class BookingRepository {
  Future<Either<Failures, PaymentModel>> getPaymentDetails(double price,List<int> roomId,int hotelId,String cIn,String cOut, double
    roomPrice, int gst, int offer, int total, int couponId);
  Future<Either<Failures, BookingModel>> getBookingDetails(
      int hotelId, String cIn, String cOut, List<int> roomId, int adults);
}
