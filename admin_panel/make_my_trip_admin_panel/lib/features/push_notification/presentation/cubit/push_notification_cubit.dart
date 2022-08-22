import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/domain/use_cases/push_notification_usecase.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/domain/use_cases/register_user_notification_usecase.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';
import 'package:meta/meta.dart';

import '../../domain/use_cases/enduser_notification_usecase.dart';
part 'push_notification_state.dart';

class PushNotificationCubit extends Cubit<BaseState> {
  PushNotificationUseCase pushNotificationUseCase;
  RegisterUserNotificationUseCase registerUserNotificationUseCase;
  EndUserNotificationUseCase endUserNotificationUseCase;

  PushNotificationCubit(this.pushNotificationUseCase,
      this.registerUserNotificationUseCase, this.endUserNotificationUseCase)
      : super(PushNotificationInitial());

  getImagefromDevice(int registerUser, int endUser) async {
    final response = await pushNotificationUseCase.call();
    response.fold(
        (l) =>  emit(StateErrorGeneral(StringConstants.errorMsgNotification)),
        (r) => emit(PushNotificationResponse(
            r.first.toString(), r.last.toString(), registerUser, endUser)));
  }

  setRadioButton(fileName, url, registerUser, endUser) async {
    emit(PushNotificationResponse(fileName, url, registerUser, endUser));
  }

  registeredUserPushNotification(String title, String body, String url) async {
    if (title.isEmpty || body.isEmpty || url.isEmpty) {
      emit(ErrorState(StringConstants.errorMsgNotification));
    } else {
      final response =
          await registerUserNotificationUseCase.call(title, body, url);
      response.fold(
          (l) =>  emit(StateErrorGeneral(StringConstants.errorMsgNotification)),
          (r) => Fluttertoast.showToast(
              msg: StringConstants.pushedNotificationToRegisteredUser));
    }
  }

  endUserPushNotification(
      String title, String body, String url, int endUser) async {
    if (title.isEmpty || body.isEmpty || url.isEmpty) {
      emit(ErrorState(StringConstants.errorMsgNotification));
    } else {
      final response = await endUserNotificationUseCase.call(title, body, url);
      response.fold(
          (l) =>  emit(StateErrorGeneral(StringConstants.errorMsgNotification)),
          (r) => Fluttertoast.showToast(
              msg: StringConstants.pushedNotificationToEndUser));
    }
  }
}
