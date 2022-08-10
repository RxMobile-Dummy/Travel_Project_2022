import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/wishlist/data/model/wishlist_model.dart';
import 'package:make_my_trip/features/wishlist/domain/use_cases/wishlist_usecase.dart';

class WishListCubit extends Cubit<BaseState> {

  WishListCubit(this.wishListUsecase) : super(StateInitial());

  final WishListUsecase wishListUsecase;
  int page=1;
  getWishListCubitData() async {
    emit(StateLoading());
    final res = await wishListUsecase.call(page);
    res.fold((l) => emit(StateErrorGeneral("errorMessage")),
        (r) => emit(StateOnSuccess<List<WishlistModel>>(r)));
  }

  getWish() async{
    if(state is StateReorderLoading) return;
    final currentState = state;
    var oldPosts = <WishlistModel>[];

    if (currentState is StateOnSuccess) {
      oldPosts = currentState.response;
    }

    emit(StateReorderLoading(oldPosts, post: page == 1));
    wishListUsecase.call(page).then((newPosts) {
      page++;

      final posts = (state as StateReorderLoading).response;
      posts.addAll(newPosts);

      emit(StateOnSuccess(posts));
    });
  }

}
