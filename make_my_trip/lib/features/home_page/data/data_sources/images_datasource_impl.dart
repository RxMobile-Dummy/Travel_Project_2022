import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/images_datasource.dart';
import 'package:make_my_trip/features/home_page/data/models/imageModel.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';
import '../../../../core/failures/failures.dart';
import '../../../hotel_listing/data/models/hotel_list_model.dart';

class ImagesDataSourceImpl implements ImagesDataSource {
  final Dio dio;

  ImagesDataSourceImpl(this.dio);

  Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    return Options(headers: {'token': userToken});
  }

  @override
  Future<Either<Failures, List<HotelListModel>>> getList() async {
    try {
      final response = await dio.get('${BaseConstant.baseUrl}hotel/image/5',
          options: await createDioOptions());
      var result = response.data;
      if (response.statusCode == 200) {
        List<HotelListModel> postList = [];
        {
          for (Map i in result) {
            postList.add(HotelListModel.fromJson(i));
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
