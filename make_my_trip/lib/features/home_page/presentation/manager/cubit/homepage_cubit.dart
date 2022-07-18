import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/features/home_page/data/models/ToursModel.dart';
import 'package:make_my_trip/features/home_page/data/models/imageModel.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/image_usecase.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/tour_usecase.dart';
import 'package:meta/meta.dart';
import '../../../../../core/failures/failures.dart';
part 'homepage_state.dart';

class HomepageCubit extends Cubit<StateOnSuccess<GettingStartedData>> {
  HomepageCubit(this.imagesusecase, this.toursusecase)
      : super(StateOnSuccess<GettingStartedData>(GettingStartedData())) {
    getImagesApi();
    getToursApi();
  }

  final ImagesUseCase imagesusecase;
  final ToursUseCase toursusecase;

  Future<Either<Failures, List<ImageModel>>?> getImagesApi() async {
    print('getimagesapi 2');
    var data = await imagesusecase.call();
    data.fold((failure) {
      debugPrint(failure.toString());
    }, (success) {
      emit(StateOnSuccess((state as StateOnSuccess<GettingStartedData>)
          .response
          .copyWith(imageListValue: success)));
    });
  }

  Future<Either<Failures, List<ToursModel>>?> getToursApi() async {
    print('get_tours_api 2');
    var data = await toursusecase.call();
    data.fold((failure) {
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

  bool checkAllCompleted() {
    return toursListValue != null && imageListValue != null;
  }
}
