import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/images_repository.dart';

import '../../../../core/failures/failures.dart';
import '../../../hotel_listing/data/models/hotel_list_model.dart';
import '../../data/models/imageModel.dart';

class GetAllImagesOfHomePageUseCase {
  final ImagesRepository imagesrepository;

  GetAllImagesOfHomePageUseCase({required this.imagesrepository});

  Future<Either<Failures, List<HotelListModel>>> call(int val) async {
    return await imagesrepository.getImages(val);
  }
}
