import 'package:make_my_trip/features/home_page/data/data_sources/images_datasource.dart';
import 'package:make_my_trip/features/home_page/data/models/imageModel.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/images_repository.dart';

class Imagerepository_impl extends Imagesrepository {
  Imagesdatasource imagesdatasource;

  Imagerepository_impl({required this.imagesdatasource});

  @override
  Stream<List<ImageModel>> getimages() {
    var reponse = imagesdatasource.getlist();

    return reponse;
  }
}
