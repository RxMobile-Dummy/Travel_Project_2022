import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/images_datasource.dart';
import 'package:make_my_trip/features/home_page/data/models/imageModel.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/images_repository.dart';
import '../../../../core/failures/failures.dart';
import '../../../hotel_listing/data/models/hotel_list_model.dart';

class ImageRepositoryImpl extends ImagesRepository {
  ImagesDataSource imagesDataSource;

  ImageRepositoryImpl({required this.imagesDataSource});

  @override
  Future<Either<Failures, List<HotelListModel>>> getImages(int val) async {
    return await imagesDataSource.getList(val);
  }
}
