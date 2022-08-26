import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';

class SplashCubit extends Cubit<BaseState> {
  SplashCubit() : super(StateInitial());

  splashLoad() async {
    await Future.delayed(const Duration(seconds: 2));
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    });
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}
