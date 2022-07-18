import 'dart:convert';
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
    final response = await dio.get('http://192.168.101.124:4000/tour/10');
    var result = response.data;
    if (response.statusCode == 200) {
      print('ToursDataSourceImpl 5');
      List<ToursModel> postlist = [];
      {
        for (Map i in result) {
          postlist.add(ToursModel.fromJson(i));
        }
      }
      return Right(postlist);
    } else {
      return Left(ServerFailure());
    }
  }
}
