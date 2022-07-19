import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/review/data/data_sources/review_remote_data_source.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final Dio dio;
  final String baseUrl = "http://192.168.102.190:3000/review/hotel/";

  ReviewRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, List<ReviewModel>>> getHotelReview(params) async {
    try {
      final response = await dio.get(baseUrl + "$params");
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
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, void>> postHotelReview(params) async {
    try {
      await dio.post(baseUrl + "1", data: params.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
