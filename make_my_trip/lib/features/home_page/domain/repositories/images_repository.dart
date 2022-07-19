import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../data/models/imageModel.dart';

abstract class ImagesRepository {
  Future<Either<Failures, List<ImageModel>>> getImages();
}
