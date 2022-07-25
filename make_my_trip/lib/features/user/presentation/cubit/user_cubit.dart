import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/core/base/base_state.dart';

part 'user_state.dart';

class UserCubit extends Cubit<BaseState> {
  UserCubit() : super(StateInitial());

  // final IsAnonymousUser isAnonymousUser;
  // final GetUser getUser;

  // checkIsAnonymousUser() async {
  //   final res = await isAnonymousUser.call(NoParams());
  //   res.fold((failure) {
  //     print(failure);
  //   }, (success) {
  //     if (success) {
  //       emit(Unauthenticated());
  //     } else {
  //       emit(Authenticated());
  //     }
  //   });
  // }

  // getUserDetail() async {
  //   final res = await getUser.call(NoParams());
  //   res.fold((failure) {
  //     print(failure);
  //   }, (success) {
  //     emit(StateOnSuccess<UserModel>(success));
  //   });
  // }
}
