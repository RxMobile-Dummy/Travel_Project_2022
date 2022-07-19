import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/hotel_detail/data/model/hotel_detail_model.dart';

abstract class HotelDetailRemoteDataSource {
  Future<Either<Failures, HotelDetailModel>> getAllHotelDetailData(int index);
}

class HotelDetailRemoteDataSourceImpl implements HotelDetailRemoteDataSource {
  final Dio dio;
  HotelDetailRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, HotelDetailModel>> getAllHotelDetailData(
      int index) async {
    return _getAllCharacterUrl(
        "https://9f4c-180-211-112-179.in.ngrok.io/hotel/5");
  }

  Future<Either<Failures, HotelDetailModel>> _getAllCharacterUrl(
      String url) async {
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        HotelDetailModel hotelDetailModel;
        final apidata = response.data;
        hotelDetailModel = HotelDetailModel.fromJson(apidata);

        return Right(hotelDetailModel);
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
