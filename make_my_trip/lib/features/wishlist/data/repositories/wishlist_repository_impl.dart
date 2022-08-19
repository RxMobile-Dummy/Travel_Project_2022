import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/wishlist/data/data_sources/wishlist_remote_data_source.dart';
import 'package:make_my_trip/features/wishlist/data/model/wishlist_model.dart';
import 'package:make_my_trip/features/wishlist/domain/repositories/wishlist_repository.dart';

class WishListRepositoryImpl implements WishListRepository {
  final WishListRemoteDataSource wishListRemoteDataSource;
  WishListRepositoryImpl(this.wishListRemoteDataSource);

  @override
  Future<Either<Failures, List<WishlistModel>>> getWishList() async {
    return await wishListRemoteDataSource.getWishListData();
  }
}
