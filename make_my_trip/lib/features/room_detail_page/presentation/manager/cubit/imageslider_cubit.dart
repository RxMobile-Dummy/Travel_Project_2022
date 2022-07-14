import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'imageslider_state.dart';

class ImagesliderCubit extends Cubit<ImagesliderState> {
  ImagesliderCubit() : super(ImagesliderInitial()) {
    getindex(0);
  }

  getindex(int i) {
    emit(GetIndexState(i));
    return i;
  }
}
