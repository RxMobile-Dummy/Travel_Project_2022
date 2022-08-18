import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/GetParticularCouponUsecase.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/image_usecase.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/tour_usecase.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/viewCoupon_usecase.dart';
import '../../../../../core/failures/failures.dart';

class HomepageCubit extends Cubit<BaseState> {
  HomepageCubit(this.imagesusecase, this.toursusecase, this.couponsusecase,
      this.getParticularCouponUsecase)
      : super(StateOnSuccess<GettingStartedData>(GettingStartedData()));
  final GetAllImagesOfHomePageUseCase imagesusecase;
  final GetAllToursOfHomepageUseCase toursusecase;
  final GetAllCouponsOfHomepage couponsusecase;
  final GetParticularCouponUsecase getParticularCouponUsecase;

  getImagesApi() async {
    try {
      emit(StateOnSuccess((state as StateOnSuccess<GettingStartedData>)
          .response
          .copyWith(imageLoading: true)));

      var data = await imagesusecase.call();
      data.fold((failure) {
        if (failure is ServerFailure) {
          emit(StateErrorGeneral(failure.failureMsg.toString()));
        }
      }, (success) {
        emit(StateOnSuccess((state as StateOnSuccess<GettingStartedData>)
            .response
            .copyWith(imageListValue: success, imageLoading: false)));
      });
    } catch (err) {}
  }

  getToursApi() async {
    try {
      emit(StateOnSuccess((state as StateOnSuccess<GettingStartedData>)
          .response
          .copyWith(tourLoading: true)));
      var data = await toursusecase.call();
      data.fold((failure) {
        if (failure is ServerFailure) {
          emit(StateErrorGeneral(failure.failureMsg.toString()));
        }
      }, (success) {
        emit(StateOnSuccess((state as StateOnSuccess<GettingStartedData>)
            .response
            .copyWith(toursListValue: success, tourLoading: false)));
      });
    } catch (err) {}
  }



  getCouponsIdApi(int id) async {
    emit(StateOnSuccess((state as StateOnSuccess<GettingStartedData>)
        .response
        .copyWith(couponLoading: true)));
    var data = await getParticularCouponUsecase.call(id);
    data.fold((failure) {
      debugPrint(failure.toString());
    }, (success) {
      print(success);
    });
  }

  getCouponsApi() async {
    emit(StateOnSuccess((state as StateOnSuccess<GettingStartedData>)
        .response
        .copyWith(couponLoading: true)));
    var data = await couponsusecase.call();
    data.fold((failure) {
      if (failure is ServerFailure) {
        emit(StateErrorGeneral(failure.failureMsg.toString()));
      }
      debugPrint(failure.toString());
    }, (success) {

      emit(StateOnSuccess((state as StateOnSuccess<GettingStartedData>)
          .response
          .copyWith(couponListValue: success, couponLoading: false)));
    });
  }

}
