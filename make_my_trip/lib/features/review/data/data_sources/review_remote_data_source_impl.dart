import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/review/data/data_sources/review_remote_data_source.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final Dio dio;


  ReviewRemoteDataSourceImpl(this.dio);

  Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    return Options(headers: {'token': userToken});
  }

  @override
  Future<Either<Failures, List<ReviewModel>>> getHotelReview(params) async {
    try {

      final response = await dio.get('${BaseConstant.baseUrl}review/hotel/${params}',options: await createDioOptions()
      );
      if (response.statusCode == 200) {
        final data = response.data;
        var reviewModel = <ReviewModel>[];
        for (var item in data) {
          reviewModel.add(ReviewModel.fromJson(item));
        }
        return Right(reviewModel);
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      print(err);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, void>> postHotelReview(params) async {
    try {
      print(params);
      await dio.post('${BaseConstant.baseUrl}review/hotel/${params}',
          data: params.toJson(),options: await createDioOptions()
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
