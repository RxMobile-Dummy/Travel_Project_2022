import 'package:bloc/bloc.dart';
import 'package:make_my_trip/features/home_page/data/models/ToursModel.dart';
import 'package:make_my_trip/features/home_page/data/models/imageModel.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/image_usecase.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/tour_usecase.dart';
import 'package:meta/meta.dart';

part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit(this.imagesusecase, this.toursusecase)
      : super(HomepageInitial()) {
    get_tours_api();
    getimagesapi();
  }

  final images_usecase imagesusecase;
  final Tours_usecase toursusecase;

  Stream<List<ImageModel>> getimagesapi() {
    var data = imagesusecase.imagesrepository.getimages();

    emit(GetData(GetList: data));
    return data;
  }

  Stream<List<ToursModel>> get_tours_api() {
    var data = toursusecase.toursRepository.get_tours();
    emit(GetToursList(GettoursList: data));
    return data;
  }
}
