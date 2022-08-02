import 'package:flutter/material.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

class MySetting {
  final IconData icon;
  final String text;
  final String routeName;

  MySetting({
    required this.routeName,
    required this.icon,
    required this.text,
  });
}

List<MySetting> settingList = [
  MySetting(
      icon: Icons.favorite_border_outlined,
      text: StringConstants.wishlist,
      routeName: RoutesName.wishList),
  MySetting(
      icon: Icons.car_rental,
      text: StringConstants.myTrips,
      routeName: RoutesName.myTrips),
  MySetting(
      icon: Icons.security,
      text: StringConstants.privacyAndSecurity,
      routeName: RoutesName.errorPage),
  MySetting(
      icon: Icons.help_outline,
      text: StringConstants.help,
      routeName: RoutesName.help),
  MySetting(
      icon: Icons.info_outline,
      text: StringConstants.aboutUs,
      routeName: RoutesName.errorPage)
];
