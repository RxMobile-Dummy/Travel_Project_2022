import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/user/domain/usecases/is_anonymous_user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<BaseState> {
  UserCubit({required this.isAnonymousUser}) : super(StateInitial());

  final IsAnonymousUser isAnonymousUser;

  checkIsAnonymousUser() async {
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
