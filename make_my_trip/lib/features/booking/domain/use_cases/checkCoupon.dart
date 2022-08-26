import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/booking/domain/repositories/booking_repository.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';

class CheckCouponUsecase {
  final BookingRepository bookingRepository;

  CheckCouponUsecase(this.bookingRepository);

  Future<Either<Failures, List<ViewCouponModel>>> call(
      CheckCouponParams params) {
    return bookingRepository.checkCoupon(params.code, params.price);
  }
}

class CheckCouponParams {
  final int price;
  final String code;
  CheckCouponParams(this.price, this.code);

  @override
  List<Object?> get props => [price, code];
}
