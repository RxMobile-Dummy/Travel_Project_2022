import 'package:dartz/dartz.dart';

import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/booking/domain/repositories/booking_repository.dart';

import '../../../../core/usecases/usecase.dart';
import '../../data/model/payment_model.dart';

class PaymentUseCase implements Usecase<PaymentModel, PaymentParams> {

  final BookingRepository bookingRepository;
  PaymentUseCase(this.bookingRepository);

  @override
  Future<Either<Failures, PaymentModel>> call(params) async {
   return await bookingRepository.getPaymentDetails(params.amt,params.roomId,params.hotelId,params.cin,params.cout,params.roomPrice,params.gst,params.offer,params.total,params.couponId);
  }
}

class PaymentParams {
  final double amt;
  final List<int> roomId;
  final int hotelId;
  final String cin;
  final String cout;
  final double roomPrice;
  final int couponId;
  final int total;
  final int offer;
  final int gst;

  PaymentParams(this.amt,this.roomId,this.hotelId,this.cin,this.cout,this.roomPrice,this.offer,this.gst,this.total,this.couponId);

  @override
  List<Object?> get props => [amt];
}