import 'package:dio/dio.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/review/data/data_sources/review_remote_data_source.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final Dio dio;
  final String baseUrl = "http://192.168.102.190:3000/review/hotel/";

  ReviewRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ReviewModel>> getHotelReview(params) async {
    try {
      final response = await dio.get(baseUrl + "${params}");
      if (response.statusCode == 200) {
        final ReviewModel reviewModel;
        final data = response.data;
        var temp = <ReviewModel>[];
        for (var item in data) {
          temp.add(ReviewModel.fromJson(item));
        }
        return temp;
      }
      else {
        throw ServerFailure();
      }
    }
    catch (err) {
      print(err);
      throw ServerFailure();
    }
  }}
