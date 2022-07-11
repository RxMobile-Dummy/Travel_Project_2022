import 'package:make_my_trip/features/home_page/data/models/imageModel.dart';

abstract class Imagesdatasource {
  Stream<List<ImageModel>> getlist();
}
