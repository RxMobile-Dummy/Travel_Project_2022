import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/user/domain/usecases/get_user.dart';
import 'package:make_my_trip/features/user/presentation/cubit/user_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/usecases/usecase.dart';

class SplashCubit extends Cubit<BaseState> {
  SplashCubit({required this.getUser}) : super(StateInitial());

  final GetUser getUser;

  splashLoad() async {
    await Future.delayed(Duration(seconds: 2));
    final res = await getUser.call(NoParams());
    res.fold((failure) {
      print(failure);
    }, (success) {
      if (success.userId != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    });

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}
