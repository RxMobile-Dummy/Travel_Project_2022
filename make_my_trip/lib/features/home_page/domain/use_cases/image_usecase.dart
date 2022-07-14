import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/images_repository.dart';

import '../../../../core/failures/failures.dart';
import '../../data/models/imageModel.dart';

class images_usecase {
  final Imagesrepository imagesrepository;
  images_usecase({required this.imagesrepository});
  Future<Either<Failures,List<ImageModel>>> call(Map map) async{
    return await imagesrepository.getimages();
  }
}
