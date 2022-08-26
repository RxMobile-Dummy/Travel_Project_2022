import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/failures/failure_handler.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/wishlist/data/model/wishlist_model.dart';
import 'package:make_my_trip/features/wishlist/domain/use_cases/wishlist_usecase.dart';

class WishListCubit extends Cubit<BaseState> {
  WishListCubit(this.wishListUsecase) : super(StateInitial());

  final WishListUsecase wishListUsecase;
  int page = -1;
  List<WishlistModel> wishList = [];

  getWishListCubitData() async {
    if (state is! StateOnSuccess) {
      emit(StateLoading());
    } else {
      emit(StateOnSuccess<List<WishlistModel>>(wishList, isMoreLoading: true));
    }
    page++;
    final res = await wishListUsecase.call(page);
    res.fold((l) {
      emit(FailureHandler.checkFailures(l));
    }, (r) {
      for (var item in r) {
        wishList.add(item);
      }
      emit(StateOnSuccess<List<WishlistModel>>(wishList, isMoreLoading: false));
    });
  }

  void setUpScrollController(ScrollController scrollController) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          getWishListCubitData();
        }
      }
    });
  }
}
