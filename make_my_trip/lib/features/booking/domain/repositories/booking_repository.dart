import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/booking/data/model/booking_model.dart';
import 'package:make_my_trip/features/booking/data/model/payment_model.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';

import '../../../../core/failures/failures.dart';

abstract class BookingRepository {
  Future<Either<Failures, PaymentModel>> getPaymentDetails(double price);
  Future<Either<Failures, BookingModel>> getBookingDetails(int hotelId,
      String cIn, String cOut, List<int> roomId, int adults, int coupon_id);
  Future<Either<Failures, List<ViewCouponModel>>> showApplicableCoupons(
      int price);
  Future<Either<Failures, List<ViewCouponModel>>> checkCoupon(
      String code, int price);
}
