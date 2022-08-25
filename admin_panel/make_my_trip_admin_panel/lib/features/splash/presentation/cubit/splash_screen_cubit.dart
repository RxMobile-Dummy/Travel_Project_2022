import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';

class SplashCubit extends Cubit<BaseState> {
  SplashCubit() : super(StateInitial());

  final LocalStorage storage = LocalStorage('userCredential');

  splashLoad() async {
    await Future.delayed(const Duration(seconds: 2));
    if (await storage.getItem("email") != null) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}
