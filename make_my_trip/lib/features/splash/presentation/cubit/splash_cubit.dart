import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_my_trip/core/base/base_state.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<BaseState> {
  SplashCubit() : super(StateInitial());

  splashLoad() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    Future.delayed(Duration(seconds: 3)).then((value) => emit(StateNoData()));
  }
}
