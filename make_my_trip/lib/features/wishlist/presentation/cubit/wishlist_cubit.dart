import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/failures/failure_handler.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/wishlist/data/model/wishlist_model.dart';
import 'package:make_my_trip/features/wishlist/domain/use_cases/wishlist_usecase.dart';

class WishListCubit extends Cubit<BaseState> {
  WishListCubit(this.wishListUsecase) : super(StateInitial());

  final WishListUsecase wishListUsecase;

  getWishListCubitData() async {
    emit(StateLoading());
    final res = await wishListUsecase.call(NoParams());
    res.fold((l) {
      emit(FailureHandler.checkFailures(l));
    }, (r) => emit(StateOnSuccess<List<WishlistModel>>(r)));
  }
}
