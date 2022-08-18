import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/viewCoupon_datasource.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/getParticularCoupon.dart';

class GetParticularCouponRepositoryImpl
    extends GetParticularCouponCouponRepository {
  ViewCouponsDataSource viewCouponsDataSource;

  GetParticularCouponRepositoryImpl({required this.viewCouponsDataSource});

  @override
  Future<Either<Failures, ViewCouponModel>> getCouponId(int id) async {
    return await viewCouponsDataSource.getCouponId(id);
  }
}
