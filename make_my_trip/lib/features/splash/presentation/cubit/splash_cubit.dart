import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/user/domain/usecases/get_user.dart';
import 'package:make_my_trip/features/user/domain/usecases/refresh_fcm_token.dart';
import 'package:make_my_trip/features/user/presentation/cubit/user_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/usecases/usecase.dart';

class SplashCubit extends Cubit<BaseState> {
  SplashCubit({required this.getUser, required this.refreshFcmToken})
      : super(StateInitial());

  final GetUser getUser;
  final RefreshFcmToken refreshFcmToken;

  splashLoad() async {
    await Future.delayed(Duration(seconds: 2));
    final res = await getUser.call(NoParams());
    res.fold((failure) {}, (success) {
      if (success.userId != null) {
        refreshFcmTokenCubit();
      } else {
        emit(Unauthenticated());
      }
    });

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  refreshFcmTokenCubit() async {
    await Future.delayed(Duration(seconds: 2));
    final res = await refreshFcmToken.call(NoParams());
    res.fold((failure) {}, (success) {
      emit(Authenticated());
    });
  }
}
