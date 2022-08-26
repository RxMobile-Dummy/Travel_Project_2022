import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/booking/domain/repositories/booking_repository.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';
import 'package:dartz/dartz.dart';

class ShowApplicableCouponsUsecase {
  final BookingRepository bookingRepository;

  ShowApplicableCouponsUsecase(this.bookingRepository);

  Future<Either<Failures, List<ViewCouponModel>>> call(
      ShowApplicableCouponParams params) {
    return bookingRepository.showApplicableCoupons(params.price);
  }
}

class ShowApplicableCouponParams {
  final int price;
  ShowApplicableCouponParams(this.price);

  @override
  List<Object?> get props => [price];
}
