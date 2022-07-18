import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/images_datasource.dart';
import 'package:make_my_trip/features/home_page/data/models/imageModel.dart';
import '../../../../core/failures/failures.dart';

class ImagesDataSourceImpl implements ImagesDataSource {
  final Dio dio;
  ImagesDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, List<ImageModel>>> getList() async {
    final response = await dio.get('http://192.168.101.124:4000/hotel/image/5');
    var result = response.data;

    if (response.statusCode == 200) {
      print('ImagesDataSourceImpl 5');
      List<ImageModel> postlist = [];
      {
        for (Map i in result) {
          postlist.add(ImageModel.fromJson(i));
        }
      }
      return Right(postlist);
    } else {
      return Left(ServerFailure());
    }
  }
}
