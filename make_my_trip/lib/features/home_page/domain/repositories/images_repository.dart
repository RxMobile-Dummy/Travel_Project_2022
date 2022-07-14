import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../data/models/imageModel.dart';

abstract class Imagesrepository {
  Future<Either<Failures,List<ImageModel>>> getimages();
}
