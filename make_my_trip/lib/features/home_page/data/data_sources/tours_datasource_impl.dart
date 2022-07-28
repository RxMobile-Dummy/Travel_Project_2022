import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/tours_datasource.dart';
import '../../../../core/failures/failures.dart';
import '../../../../utils/constants/base_constants.dart';
import '../models/ToursModel.dart';

class ToursDataSourceImpl implements ToursDataSource {
  final Dio dio;

  ToursDataSourceImpl(this.dio);
  Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    return Options(headers: {'token': userToken});
  }

  @override
  Future<Either<Failures, List<ToursModel>>> getToursData() async {
    try {
      final response = await dio.get('${BaseConstant.baseUrl}tour/5',
          options: await createDioOptions());
      print(BaseConstant.baseUrl);
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
      print(e);
      return Left(ServerFailure(statusCode: "503"));
    }
  }
}
