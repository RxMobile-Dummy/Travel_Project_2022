import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/features/wishlist/data/model/wishlist_model.dart';

import '../../../../core/failures/failure_handler.dart';
import '../../../../core/failures/failures.dart';
import '../../../../utils/constants/base_constants.dart';

abstract class WishListRemoteDataSource {
  Future<Either<Failures, List<WishlistModel>>> getWishListData(int page);
}

class WishListRemoteDataSourceImpl implements WishListRemoteDataSource {
  final Dio dio;

  WishListRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, List<WishlistModel>>> getWishListData(int page) {
    return _getAllCharacterUrl(
        "${BaseConstant.baseUrl}bookmark/user/wishlist", page);
  }

  Future<Either<Failures, List<WishlistModel>>> _getAllCharacterUrl(
      String url, int page) async {
    try {
      var params = {"pagesize": 3, "page": page};
      final response = await dio.get(url,
          queryParameters: params,
          options: await BaseConstant.createDioOptions());

      final res = await FailureHandler.handleError(response);
      return res.fold((l) => Left(l), (r) {
        List<WishlistModel> wishListModel = [];
        final apidata = response.data;
        for (var item in apidata) {
          wishListModel.add(WishlistModel.fromJson(item));
        }

        return Right(wishListModel);
      });
    } on SocketException {
      return Left(InternetFailure());
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
