
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';

import '../../../hotel_detail/data/model/hotel_detail_model.dart';


class GalleryCubit extends Cubit<BaseState> {
  GalleryCubit() : super(StateInitial());

  void setPage(int index){
    emit(StateOnSuccess<int>(index));
  }

  convertImageData(List<Images> imageList){
    List<String> image=[];
    imageList.forEach((element) {
      image.add(element.imageUrl.toString());
    });
    emit(StateOnSuccess<List<String>>(image));
  }
}
