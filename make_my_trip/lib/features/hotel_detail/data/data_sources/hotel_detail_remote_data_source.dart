import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/hotel_detail/data/model/hotel_detail_model.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';

abstract class HotelDetailRemoteDataSource {
  Future<Either<Failures, HotelDetailModel>> getAllHotelDetailData(int index);
  Future<Either<Failures, void>> postIsLikeData(int hotelId);
  Future<Either<Failures, void>> deleteIsLikeData(int hotelId);
}

class HotelDetailRemoteDataSourceImpl implements HotelDetailRemoteDataSource {
  final Dio dio;
  HotelDetailRemoteDataSourceImpl(this.dio);

  Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    printWrapped(userToken);
    return Options(headers: {'token': userToken});
  }

  @override
  Future<Either<Failures, HotelDetailModel>> getAllHotelDetailData(
      int index) async {
    return _getAllCharacterUrl(
        "${BaseConstant.baseUrl}hotel/gethotel/getsinglehotel/${index}");
  }

  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  Future<Either<Failures, HotelDetailModel>> _getAllCharacterUrl(
      String url) async {
    try {
      final response = await dio.get(url, options: await createDioOptions());
      if (response.statusCode == 200) {
        HotelDetailModel hotelDetailModel;
        final apidata = response.data;
        hotelDetailModel = HotelDetailModel.fromJson(apidata);
        return Right(hotelDetailModel);
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      print(err);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, void>> deleteIsLikeData(int hotelId) async {
    try {
      final response = await dio.delete(
          "${BaseConstant.baseUrl}bookmark/delete/${hotelId}",
          options: await createDioOptions());
      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      print(err);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, void>> postIsLikeData(int hotelId) async {
    try {
      final response = await dio.post(
          "${BaseConstant.baseUrl}bookmark/post/${hotelId}",
          options: await createDioOptions());
      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      print(err);
      return Left(ServerFailure());
    }
  }
}
