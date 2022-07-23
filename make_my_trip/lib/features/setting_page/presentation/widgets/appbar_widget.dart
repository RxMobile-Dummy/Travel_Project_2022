import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

AppBar settingPageAppBarWidget() {
  return AppBar(
    elevation: 0,
    backgroundColor: MakeMyTripColors.colorWhite,
    leading:
        const Icon(Icons.arrow_back_ios, color: MakeMyTripColors.colorBlack),
    title: const Text(StringConstants.setting,
        style: TextStyle(
            color: MakeMyTripColors.colorBlack, fontWeight: FontWeight.bold)),
  );
}
