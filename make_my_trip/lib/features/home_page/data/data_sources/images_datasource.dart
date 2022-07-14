import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/home_page/data/models/imageModel.dart';

abstract class Imagesdatasource {
  Future<Either<Failures,List<ImageModel>>> getlist();
}
