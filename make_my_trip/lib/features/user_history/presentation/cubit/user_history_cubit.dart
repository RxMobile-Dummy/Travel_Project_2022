import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/user_history/data/model/user_history_model.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/user_history/domain/use_cases/user_history_usecase.dart';

import '../../data/model/user_history_model.dart';

class UserHistoryCubit extends Cubit<BaseState> {
  UserHistoryCubit(this.userHistoryUsecase) : super(StateInitial());
  final UserHistoryUsecase userHistoryUsecase;
  int page = -1;
  List<UserHistoryModel> historyList = [];

  getUserHistoryData() async {
    if (state is !StateOnSuccess) {
      emit(StateLoading());
    }else{
      emit(StateOnSuccess<List<UserHistoryModel>>(historyList,isMoreLoading: true));
    }
    page++;
    final res = await userHistoryUsecase.call(page);
    res.fold((l) {
      emit(StateErrorGeneral("errorMessage"));
    }, (r) {
      for (var item in r) {
        historyList.add(item);
      }
      emit(StateOnSuccess<List<UserHistoryModel>>(historyList,isMoreLoading: false));
    });
  }

  void setUpScrollController(ScrollController scrollController) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          getUserHistoryData();
        }
      }
    });
  }
}
