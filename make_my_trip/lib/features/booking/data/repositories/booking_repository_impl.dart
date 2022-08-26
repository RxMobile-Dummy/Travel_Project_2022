import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/booking/data/data_sources/booking_remote_data_source.dart';
import 'package:make_my_trip/features/booking/data/model/booking_model.dart';
import 'package:make_my_trip/features/booking/data/model/payment_model.dart';
import 'package:make_my_trip/features/booking/domain/repositories/booking_repository.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource bookingRemoteDataSource;
  BookingRepositoryImpl(this.bookingRemoteDataSource);

  @override
  Future<Either<Failures, PaymentModel>> getPaymentDetails(double price) async {
    return await bookingRemoteDataSource.paymentIntegerationDataSource(price);
  }

  @override
  Future<Either<Failures, BookingModel>> getBookingDetails(
      int hotelId,
      String cIn,
      String cOut,
      List<int> roomId,
      int adults,
      int coupon_id) async {
    return await bookingRemoteDataSource.bookingRemoteDataSource(
        hotelId, cIn, cOut, roomId, adults, coupon_id);
  }

  @override
  Future<Either<Failures, List<ViewCouponModel>>> showApplicableCoupons(
      int price) async {
    // TODO: implement showApplicableCoupons
    return await bookingRemoteDataSource.showApplicableCoupons(price);
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<ViewCouponModel>>> checkCoupon(
      String code, int price) async {
    // TODO: implement checkCoupon
    return await bookingRemoteDataSource.checkCoupon(price, code);
  }
}
