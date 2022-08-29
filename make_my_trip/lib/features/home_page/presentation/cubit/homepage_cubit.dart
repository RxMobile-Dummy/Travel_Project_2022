import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/GetParticularCouponUsecase.dart';
import 'package:make_my_trip/core/failures/failure_handler.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/image_usecase.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/tour_usecase.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/viewCoupon_usecase.dart';
import 'package:make_my_trip/features/hotel_listing/data/models/hotel_list_model.dart';
import '../../../../../core/failures/failures.dart';

class HomepageCubit extends Cubit<BaseState> {
  HomepageCubit(this.imagesusecase, this.toursusecase, this.couponsusecase,
      this.getParticularCouponUsecase)
      : super(GettingStartedData());

  final GetAllImagesOfHomePageUseCase imagesusecase;
  final GetAllToursOfHomepageUseCase toursusecase;
  final GetAllCouponsOfHomepage couponsusecase;
  final GetParticularCouponUsecase getParticularCouponUsecase;

  // getPopularHotel() async {
  //   try {
  //     var data = await imagesusecase.call(50);
  //     data.fold((failure) {
  //       if (failure is ServerFailure) {
  //         emit(FailureHandler.checkFailures(failure));
  //       }
  //     }, (success) {
  //       emit(StateOnSuccess<List<HotelListModel>>(success));
  //     });
  //   } catch (err) {}
  // }

  getImagesApi() async {
    emit((state as GettingStartedData).copyWith(imageLoading: true));
    var data = await imagesusecase.call(5);
    data.fold((failure) {
      emit((state as GettingStartedData).copyWith(imageLoading: false));
    }, (success) {
      emit((state as GettingStartedData)
          .copyWith(imageListValue: success, imageLoading: false));
    });
  }

  getToursApi() async {
    emit((state as GettingStartedData).copyWith(tourLoading: true));
    var data = await toursusecase.call();
    data.fold((failure) {
      emit((state as GettingStartedData).copyWith(tourLoading: false));
    }, (success) {
      emit((state as GettingStartedData)
          .copyWith(toursListValue: success, tourLoading: false));
    });
  }

  getCouponsApi() async {
    emit((state as GettingStartedData).copyWith(couponLoading: true));
    var data = await couponsusecase.call();
    data.fold((failure) {
      emit((state as GettingStartedData).copyWith(couponLoading: false));
    }, (success) {
      emit((state as GettingStartedData)
          .copyWith(couponListValue: success, couponLoading: false));
    });
  }
}
