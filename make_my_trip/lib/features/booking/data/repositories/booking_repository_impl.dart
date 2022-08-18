import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/booking/data/data_sources/booking_remote_data_source.dart';
import 'package:make_my_trip/features/booking/data/model/booking_model.dart';
import 'package:make_my_trip/features/booking/data/model/payment_model.dart';
import 'package:make_my_trip/features/booking/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource bookingRemoteDataSource;
  BookingRepositoryImpl(this.bookingRemoteDataSource);

  @override
  Future<Either<Failures, PaymentModel>> getPaymentDetails(double price,List<int> roomId,int hotelId,String cIn,String cOut, double
    roomPrice, int gst, int offer, int total, int couponId) async {
    return await bookingRemoteDataSource.paymentIntegerationDataSource(price,roomId,hotelId,cIn,cOut,roomPrice,gst,offer,total,couponId);
  }

  @override
  Future<Either<Failures, BookingModel>> getBookingDetails(int hotelId,
      String cIn, String cOut, List<int> roomId, int adults) async {
    return await bookingRemoteDataSource.bookingRemoteDataSource(
        hotelId, cIn, cOut, roomId, adults);
  }
}
