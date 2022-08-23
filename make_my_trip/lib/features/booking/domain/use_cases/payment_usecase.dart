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
    return await bookingRepository.getPaymentDetails(params.amt);
  }
}

class PaymentParams {
  final double amt;
  PaymentParams(this.amt);

  @override
  List<Object?> get props => [amt];
}
