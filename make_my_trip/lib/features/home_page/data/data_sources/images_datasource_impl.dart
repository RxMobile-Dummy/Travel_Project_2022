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
    try {
      final response =
          await dio.get('http://192.168.102.79:4000/hotel/image/5');
      var result = response.data;
      if (response.statusCode == 200) {
        List<ImageModel> postList = [];
        {
          for (Map i in result) {
            postList.add(ImageModel.fromJson(i));
          }
        }
        return Right(postList);
      } else if (response.statusCode == 505) {
        return Left(ServerFailure());
      } else if (response.statusCode == 404) {
        return Left(
            AuthFailure()); //Data Not Found Failure but in failure there is not method so AuthFailure
      } else {
        return Left(InternetFailure());
      }
    } catch (e) {
      return Left(ServerFailure(statusCode: "503"));
    }
  }
}
