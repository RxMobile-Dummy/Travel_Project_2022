import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/user_history/data/model/user_history_model.dart';
import 'package:make_my_trip/features/user_history/domain/use_cases/user_history_usecase.dart';

class UserHistoryCubit extends Cubit<BaseState> {
  UserHistoryCubit(this.userHistoryUsecase) : super(StateInitial());
  final UserHistoryUsecase userHistoryUsecase;

  getUserHistoryData() async {
    emit(StateLoading());
    final res = await userHistoryUsecase.call(NoParams());
    res.fold((l) {
      emit(StateErrorGeneral("errorMessage"));
    }, (r) async {
      emit(StateOnSuccess<List<UserHistoryModel>>(r));
    });
  }
}
