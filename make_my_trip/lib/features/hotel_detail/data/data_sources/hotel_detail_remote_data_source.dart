import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/hotel_detail/data/model/hotel_detail_model.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';

import '../../../../core/failures/failure_handler.dart';

abstract class HotelDetailRemoteDataSource {
  Future<Either<Failures, HotelDetailModel>> getAllHotelDetailData(int index);
  Future<Either<Failures, void>> postIsLikeData(int hotelId);
  Future<Either<Failures, void>> deleteIsLikeData(int hotelId);
}

class HotelDetailRemoteDataSourceImpl implements HotelDetailRemoteDataSource {
  final Dio dio;
  HotelDetailRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, HotelDetailModel>> getAllHotelDetailData(
      int index) async {
    return _getAllCharacterUrl(
        "${BaseConstant.baseUrl}hotel/gethotel/getsinglehotel/${index}");
  }

  Future<Either<Failures, HotelDetailModel>> _getAllCharacterUrl(
      String url) async {
    try {
      final response =
          await dio.get(url, options: await BaseConstant.createDioOptions());

      final res = await FailureHandler.handleError(response);
      return res.fold((l) => Left(l), (r) {
        HotelDetailModel hotelDetailModel;
        final apidata = r.data;
        hotelDetailModel = HotelDetailModel.fromJson(apidata);
        return Right(hotelDetailModel);
      });
    } on SocketException {
      return Left(InternetFailure());
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, void>> deleteIsLikeData(int hotelId) async {
    try {
      final response = await dio.delete(
          "${BaseConstant.baseUrl}bookmark/delete/${hotelId}",
          options: await BaseConstant.createDioOptions());
      final res = await FailureHandler.handleError(response);
      return res.fold((l) => Left(l), (r) {
        return const Right(null);
      });
    } on SocketException {
      return Left(InternetFailure());
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, void>> postIsLikeData(int hotelId) async {
    try {
      final response = await dio.post(
          "${BaseConstant.baseUrl}bookmark/post/${hotelId}",
          options: await BaseConstant.createDioOptions());
      final res = await FailureHandler.handleError(response);
      return res.fold((l) => Left(l), (r) {
        return const Right(null);
      });
    } on SocketException {
      return Left(InternetFailure());
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
