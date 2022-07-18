import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/images_datasource.dart';
import 'package:make_my_trip/features/home_page/data/models/imageModel.dart';
import 'package:http/http.dart' as http;
import '../../../../core/failures/failures.dart';

class ImagesDataSourceImpl implements ImagesDataSource {
  @override
  Future<Either<Failures, List<ImageModel>>> getList() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.101.124:4000/hotel/image/5'));
      var data = jsonDecode(response.body.toString());
      List<ImageModel> postlist = [];
      {
        for (Map i in data) {
          postlist.add(ImageModel.fromJson(i));
        }
      }
      return Right(postlist);
    } catch (e) {
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }
}
