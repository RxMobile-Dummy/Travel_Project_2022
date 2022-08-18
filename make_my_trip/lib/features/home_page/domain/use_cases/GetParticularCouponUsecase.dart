import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/getParticularCoupon.dart';

class GetParticularCouponUsecase {
  final GetParticularCouponCouponRepository getParticularCouponCouponRepository;

  GetParticularCouponUsecase(this.getParticularCouponCouponRepository);

  Future<Either<Failures, ViewCouponModel>> call(int id) async {
    return await getParticularCouponCouponRepository.getCouponId(id);
  }
}
