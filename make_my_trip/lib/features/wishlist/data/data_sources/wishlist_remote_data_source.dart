import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/features/wishlist/data/model/wishlist_model.dart';

import '../../../../core/failures/failures.dart';
import '../../../../utils/constants/base_constants.dart';

abstract class WishListRemoteDataSource {
  Future<Either<Failures, List<WishlistModel>>> getWishListData();
}

class WishListRemoteDataSourceImpl implements WishListRemoteDataSource {
  final Dio dio;

  WishListRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, List<WishlistModel>>> getWishListData() {
    return _getAllCharacterUrl("${BaseConstant.baseUrl}bookmark/user/wishlist");
  }

  Future<Either<Failures, List<WishlistModel>>> _getAllCharacterUrl(
      String url) async {
    try {
      final response =
          await dio.get(url, options: await BaseConstant.createDioOptions());

      if (response.statusCode == 200) {
        List<WishlistModel> wishListModel = [];
        final apidata = response.data;
        for (var item in apidata) {
          wishListModel.add(WishlistModel.fromJson(item));
        }

        return Right(wishListModel);
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
