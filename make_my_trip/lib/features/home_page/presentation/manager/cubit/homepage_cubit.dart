import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/features/home_page/data/models/ToursModel.dart';
import 'package:make_my_trip/features/home_page/data/models/imageModel.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/image_usecase.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/tour_usecase.dart';
import 'package:meta/meta.dart';

part 'homepage_state.dart';

class HomepageCubit extends Cubit<StateOnSuccess<GettingStartedData>> {
  HomepageCubit(this.imagesusecase, this.toursusecase)
      : super(StateOnSuccess<GettingStartedData>(GettingStartedData())) {

  getimagesapi();
  get_tours_api();
  }

  final images_usecase imagesusecase;
  final Tours_usecase toursusecase;

  getimagesapi() async{
    var data = await imagesusecase.imagesrepository.getimages();
    emit(StateOnSuccess((state as StateOnSuccess<GettingStartedData>)
        .response
        .copyWith(imageListValue: data)));

    //return await data;
  }

  get_tours_api() async {
    var data = await toursusecase.toursRepository.get_tours();
    emit(StateOnSuccess((state as StateOnSuccess<GettingStartedData>)
        .response
        .copyWith(toursListValue: data)));
   // return await data;
  }
}


class GettingStartedData {
  List<ToursModel>? toursListValue;
  List<ImageModel>? imageListValue;


  GettingStartedData(
      {this.toursListValue,this.imageListValue});

  GettingStartedData copyWith({
    List<ToursModel>? toursListValue,
    List<ImageModel>? imageListValue,
  }) =>
      GettingStartedData(
        toursListValue: toursListValue ?? this.toursListValue,
        imageListValue: imageListValue ?? this.imageListValue

      );

  bool checkAllCompleted() {
    return toursListValue != null && imageListValue != null;
  }

}
