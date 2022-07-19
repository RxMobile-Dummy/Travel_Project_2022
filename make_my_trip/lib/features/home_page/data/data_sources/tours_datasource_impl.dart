import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/tours_datasource.dart';
import '../../../../core/failures/failures.dart';
import '../models/ToursModel.dart';

class ToursDataSourceImpl implements ToursDataSource {
  final Dio dio;

  ToursDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, List<ToursModel>>> getToursData() async {
    try {
      final response = await dio.get('http://192.168.102.79:4000/tour/10');
      var result = response.data;
      if (response.statusCode == 200) {
        List<ToursModel> postList = [];
        {
          for (Map i in result) {
            postList.add(ToursModel.fromJson(i));
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
