import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/booking/data/model/payment_model.dart';

import '../../../../core/failures/failures.dart';

abstract class BookingRepository {
  Future<Either<Failures, PaymentModel>> getPaymentDetails(double price);
}
