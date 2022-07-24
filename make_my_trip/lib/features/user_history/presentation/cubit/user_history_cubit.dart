import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/user_history/data/model/user_history_model.dart';
import 'package:make_my_trip/features/user_history/domain/use_cases/user_history_usecase.dart';

class UserHistoryCubit extends Cubit<BaseState> {
  UserHistoryCubit(this.userHistoryUsecase) : super(StateInitial()){
    print('object');
    getUserHistoryData();
  }
  final UserHistoryUsecase userHistoryUsecase;

  getUserHistoryData() async {
    print("cubitcall");
    emit(StateLoading());
    final res = await userHistoryUsecase.call(NoParams());
    res.fold((l) {
      print(l.toString());
      emit(StateNoData());},
        (r) {
      print(r.toString());
      emit(StateOnSuccess<List<UserHistoryModel>>(r));});
  }
}
