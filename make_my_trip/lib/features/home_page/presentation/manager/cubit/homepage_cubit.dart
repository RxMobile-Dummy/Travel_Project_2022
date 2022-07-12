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

  getimagesapi() async{
    var data = await imagesusecase.imagesrepository.getimages();

    emit(GetData(GetList: data));

    return await data;
  }

  get_tours_api() async {
    var data = await toursusecase.toursRepository.get_tours();
    emit(GetToursList( GetList: data));
    return await data;
  }
}
