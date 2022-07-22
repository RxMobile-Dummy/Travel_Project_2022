import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

Widget customIconWidget(BuildContext context, IconData iconName, String label,
    [String? routesName]) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: MakeMyTripColors.customLightBlue,
                blurRadius: 1.5,
                spreadRadius: 1,
              )
            ],
            shape: BoxShape.circle,
            border:
                Border.all(color: MakeMyTripColors.customLightBlue, width: 2)),
        child: ClipOval(
          child: Material(
            color: MakeMyTripColors.colorWhite,
            // button color
            child: InkWell(
              child: SizedBox(
                width: 60,
                height: 60,
                child: Icon(
                  iconName,
                  color: MakeMyTripColors.customDarkBlue,
                  size: 35,
                ),
              ),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, routesName!, (route) => true);
              },
            ),
          ),
        ),
      ),
      4.verticalSpace,
      Text(label, style: AppTextStyles.infoContentStyle)
    ],
  );
}
