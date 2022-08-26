import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';

abstract class ViewCouponRepository {
  Future<Either<Failures, List<ViewCouponModel>>> getCoupons();
}
