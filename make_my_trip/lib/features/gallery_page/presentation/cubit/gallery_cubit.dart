import 'package:bloc/bloc.dart';
import 'package:make_my_trip/features/gallery_page/presentation/pages/gallery_page.dart';
import 'package:meta/meta.dart';


part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(GalleryInitial());

  void setPage(int index){
    emit(GalleryChangedPage(index));
  }

}
