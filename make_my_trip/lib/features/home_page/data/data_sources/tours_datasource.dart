import '../models/ToursModel.dart';

abstract class ToursDataSource {
  Stream<List<ToursModel>> get_tours();
}
