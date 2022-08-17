import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/viewCoupon_repository.dart';

class GetAllCouponsOfHomepage {
  final ViewCouponRepository viewCouponRepository;

  GetAllCouponsOfHomepage({required this.viewCouponRepository});

  Future<Either<Failures, List<ViewCouponModel>>> call() {
    return viewCouponRepository.getCoupons();
  }
}
