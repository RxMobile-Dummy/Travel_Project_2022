import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/home_page/data/models/ToursModel.dart';
import 'package:make_my_trip/features/home_page/data/models/imageModel.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/image_usecase.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/tour_usecase.dart';
import '../../../../../core/failures/failures.dart';

class HomepageCubit extends Cubit<BaseState> {
  HomepageCubit(this.imagesusecase, this.toursusecase)
      : super(StateOnSuccess<GettingStartedData>(GettingStartedData())) {
    getImagesApi();
    getToursApi();
  }

  final GetAllImagesOfHomePageUseCase imagesusecase;
  final GetAllToursOfHomepageUseCase toursusecase;

  getImagesApi() async {
    var data = await imagesusecase.call();
    data.fold((failure) {
      if (failure is ServerFailure) {
        emit(StateErrorGeneral(failure.failureMsg.toString()));
      }
    }, (success) {
      emit(StateOnSuccess((state as StateOnSuccess<GettingStartedData>)
          .response
          .copyWith(imageListValue: success)));
    });
  }

  getToursApi() async {
    var data = await toursusecase.call();
    data.fold((failure) {
      if (failure is ServerFailure) {
        emit(StateErrorGeneral(failure.failureMsg.toString()));
      }
      debugPrint(failure.toString());
    }, (success) {
      emit(StateOnSuccess((state as StateOnSuccess<GettingStartedData>)
          .response
          .copyWith(toursListValue: success)));
    });
  }
}

class GettingStartedData {
  List<ToursModel>? toursListValue;
  List<ImageModel>? imageListValue;

  GettingStartedData({this.toursListValue, this.imageListValue});

  GettingStartedData copyWith({
    List<ToursModel>? toursListValue,
    List<ImageModel>? imageListValue,
  }) =>
      GettingStartedData(
          toursListValue: toursListValue ?? this.toursListValue,
          imageListValue: imageListValue ?? this.imageListValue);
}
