import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/user/domain/usecases/get_user.dart';
import 'package:make_my_trip/features/user/domain/usecases/refresh_fcm_token.dart';

import '../../../../core/usecases/usecase.dart';

class SplashCubit extends Cubit<BaseState> {
  SplashCubit({required this.getUser, required this.refreshFcmToken})
      : super(StateInitial());

  final GetUser getUser;
  final RefreshFcmToken refreshFcmToken;

  Future<String?> handleDynamicLinks() async {
    try {
      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri deepLink = data!.link;
      var paramValue = deepLink.queryParameters['paramId'];
      return paramValue;
    } catch (e) {
      return null;
    }
  }

  splashLoad() async {
    await Future.delayed(const Duration(seconds: 2));
    final res = await getUser.call(NoParams());
    final String? linkData = await handleDynamicLinks();
    res.fold((failure) {
      emit(StateErrorGeneralStateErrorServer());
    }, (success) {
      if (success.userId != null) {
        refreshFcmTokenCubit();
        emit(StateOnResponseSuccess(linkData));
      } else {
        emit(StateOnSuccess(linkData));
      }
    });

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  refreshFcmTokenCubit() async {
    final res = await refreshFcmToken.call(NoParams());
    res.fold((failure) {
      emit(StateErrorGeneralStateErrorServer());
    }, (success) {
      emit(Authenticated());
    });
  }
}
