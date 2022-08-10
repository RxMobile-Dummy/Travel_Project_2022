import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/wishlist/data/model/wishlist_model.dart';
import 'package:make_my_trip/features/wishlist/domain/repositories/wishlist_repository.dart';

class WishListUsecase implements Usecase<List<WishlistModel>, int> {
  final WishListRepository wishListRepository;
  WishListUsecase(this.wishListRepository);

  @override
  Future<Either<Failures, List<WishlistModel>>> call(int page) async {

    return await wishListRepository.getWishList(page);
  }
}
