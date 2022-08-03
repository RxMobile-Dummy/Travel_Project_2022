import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/features/user/domain/usecases/get_user.dart';

import '../../../../core/usecases/usecase.dart';

class SplashCubit extends Cubit<BaseState> {
  SplashCubit({required this.getUser}) : super(StateInitial());

  final GetUser getUser;

  Future<String> handleDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data!.link;
    var paramValue = deepLink.queryParameters['paramId'];
    return paramValue ?? "";
  }

  splashLoad() async {
    await Future.delayed(const Duration(seconds: 2));
    final res = await getUser.call(NoParams());
    final String linkData = await handleDynamicLinks();
    res.fold((failure) {}, (success) {
      if (success.userId != null) {
        emit(StateOnResponseSuccess(linkData));
      } else {
        emit(StateOnSuccess(linkData));
      }
    });

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}
