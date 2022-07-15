import 'package:make_my_trip/features/review/data/model/review_model.dart';

abstract class ReviewRemoteDataSource {
  Future<List<ReviewModel?>> getHotelReview(params);
}

