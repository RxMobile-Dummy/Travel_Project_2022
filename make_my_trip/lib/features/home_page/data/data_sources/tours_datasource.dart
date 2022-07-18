import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';

import '../models/ToursModel.dart';

abstract class ToursDataSource {
  Future<Either<Failures, List<ToursModel>>> getToursData();
}
