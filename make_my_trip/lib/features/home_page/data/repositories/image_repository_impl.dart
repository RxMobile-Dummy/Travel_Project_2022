import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/images_datasource.dart';
import 'package:make_my_trip/features/home_page/data/models/imageModel.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/images_repository.dart';
import '../../../../core/failures/failures.dart';

class ImageRepositoryImpl extends ImagesRepository {
  ImagesDataSource imagesdatasource;

  ImageRepositoryImpl({required this.imagesdatasource});

  @override
  Future<Either<Failures, List<ImageModel>>> getImages() async {
    var reponse = await imagesdatasource.getList();
    return reponse;
  }
}
