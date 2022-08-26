import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/viewCoupon_datasource.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/viewCoupon_repository.dart';

class ViewCouponRepositoryImpl extends ViewCouponRepository {
  ViewCouponsDataSource viewCouponsDataSource;

  ViewCouponRepositoryImpl({required this.viewCouponsDataSource});

  @override
  Future<Either<Failures, List<ViewCouponModel>>> getCoupons() async {
    return await viewCouponsDataSource.getCouponsData();
  }
}
