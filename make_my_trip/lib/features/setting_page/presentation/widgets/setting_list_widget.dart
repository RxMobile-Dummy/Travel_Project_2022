import 'package:flutter/material.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

class MySetting {
  final IconData icon;
  final String text;
  final String routeName;
  final Map<String,dynamic>? argument;

  MySetting({
    required this.routeName,
    required this.icon,
    required this.text,
    this.argument
  });
}

List<MySetting> settingList = [
  MySetting(
      icon: Icons.favorite_border_outlined,
      text: StringConstants.wishlist,
      routeName: RoutesName.wishList, argument: {"route_name":RoutesName.search}),
  MySetting(
      icon: Icons.car_rental,
      text: StringConstants.myTrips,
      routeName: RoutesName.myTrips,argument: {"route_name":RoutesName.settingPage}),
  MySetting(
      icon: Icons.security,
      text: StringConstants.privacyAndSecurity,
      routeName: RoutesName.privacyAndSecurity),
  MySetting(
      icon: Icons.help_outline,
      text: StringConstants.help,
      routeName: RoutesName.help),
  MySetting(
      icon: Icons.info_outline,
      text: StringConstants.aboutUs,
      routeName: RoutesName.aboutUs)
];
