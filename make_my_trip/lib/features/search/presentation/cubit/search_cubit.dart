import 'package:bloc/bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/user/domain/usecases/is_anonymous_user.dart';

import '../../../../core/usecases/usecase.dart';

class SearchCubit extends Cubit<BaseState> {
  SearchCubit({required this.isAnonymousUser}) : super(StateInitial());

  final IsAnonymousUser isAnonymousUser;

  goToWishlist() async {
    final res = await isAnonymousUser.call(NoParams());
    res.fold((failure) {
      print(failure);
    }, (success) {
      if (success) {
        emit(Unauthenticated());
      } else {
        emit(Authenticated());
      }
    });
  }
}
