import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/wishlist/data/model/wishlist_model.dart';

import '../../../../core/failures/failures.dart';

abstract class WishListRepository {
  Future<Either<Failures, List<WishlistModel>>> getWishList();
}
