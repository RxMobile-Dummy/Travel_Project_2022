import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';

AppBar commonAppBarWidget(
    {required String text,
    required BuildContext context,
    required String routename}) {
  return AppBar(
    elevation: 0,
    backgroundColor: MakeMyTripColors.colorWhite,
    leading: IconButton(
      icon:
          const Icon(Icons.arrow_back_ios, color: MakeMyTripColors.colorBlack),
      onPressed: () {
        Navigator.pop(context);
        // Navigator.pushNamedAndRemoveUntil(context, routename, (route) => false);
      },
    ),
    title: Text(text,
        style: const TextStyle(
            color: MakeMyTripColors.colorBlack, fontWeight: FontWeight.bold)),
  );
}
