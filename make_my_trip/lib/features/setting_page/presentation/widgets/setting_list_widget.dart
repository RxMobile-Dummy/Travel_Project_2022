import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class MySetting {
  final IconData icon;
  final String text;

  MySetting({
    required this.icon,
    required this.text,
  });
}

List<MySetting> settingList = [
  MySetting(
      icon: Icons.favorite_border_outlined, text: StringConstants.wishlist),
  MySetting(icon: Icons.car_rental, text: StringConstants.myTrips),
  MySetting(icon: Icons.security, text: StringConstants.privacyAndSecurity),
  MySetting(icon: Icons.help_outline, text: StringConstants.help),
  MySetting(icon: Icons.info_outline, text: StringConstants.aboutUs),
  MySetting(icon: Icons.logout, text: StringConstants.logout)
];

Widget settingListWidget() {
  return SizedBox(
    height: 300,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: settingList.length,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 22, right: 2),
                child: Row(
                  children: [
                    Icon(settingList[index].icon),
                    10.horizontalSpace,
                    Text(settingList[index].text,
                        style: AppTextStyles.infoLabelStyle
                            .copyWith(fontSize: 16)),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: MakeMyTripColors.color30gray,
                    )
                  ],
                ),
              )),
    ),
  );
}
