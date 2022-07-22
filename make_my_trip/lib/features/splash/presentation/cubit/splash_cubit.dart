import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/splash/domain/usecases/logIn_anonymously.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<BaseState> {
  SplashCubit({required this.logInAnonymously}) : super(StateInitial());

  final LogInAnonymously logInAnonymously;

  splashLoad() async {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    Future.delayed(Duration(seconds: 2)).then((value) => emit(StateNoData()));
  }

  String _getFailure(failure) {
    if (failure is ServerFailure) {
      return failure.failureMsg!;
    } else {
      if (failure is AuthFailure) {
        return failure.failureMsg!;
      } else {
        return "Unexpected Error";
      }
    }
  }
}
