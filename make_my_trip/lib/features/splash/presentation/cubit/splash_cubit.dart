import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<BaseState> {
  SplashCubit() : super(StateInitial());

  splashLoad() async {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    Future.delayed(Duration(seconds: 2)).then((value) => emit(StateNoData()));
  }
}
