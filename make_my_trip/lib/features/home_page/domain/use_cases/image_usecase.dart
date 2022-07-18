import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/images_repository.dart';

import '../../../../core/failures/failures.dart';
import '../../data/models/imageModel.dart';

class ImagesUseCase {
  final ImagesRepository imagesrepository;
  ImagesUseCase({required this.imagesrepository});
  Future<Either<Failures, List<ImageModel>>> call() async {
    print('ImageUseCase 3');
    return await imagesrepository.getImages();
  }
}
