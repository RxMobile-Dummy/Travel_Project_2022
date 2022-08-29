import 'package:flutter/material.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

class DrawerListTileWidget {
  final IconData iconData;
  final String title;

  DrawerListTileWidget({required this.iconData, required this.title});
}

List<DrawerListTileWidget> drawerListTileData = [
  DrawerListTileWidget(
      iconData: Icons.hotel_rounded, title: StringConstants.hotelLabel),
  DrawerListTileWidget(
      iconData: Icons.calendar_month_sharp,
      title: StringConstants.bookingModerationLabel),
  DrawerListTileWidget(
      iconData: Icons.edit_note_rounded,
      title: StringConstants.reviewAppbarTitle),
  DrawerListTileWidget(
      iconData: Icons.notifications, title: StringConstants.pushNotification),
  DrawerListTileWidget(iconData: Icons.message, title: StringConstants.faq),
  DrawerListTileWidget(
      iconData: Icons.info_rounded, title: StringConstants.aboutUs),
  DrawerListTileWidget(
      iconData: Icons.note_alt_rounded, title: StringConstants.tc),
  DrawerListTileWidget(
      iconData: Icons.shield_rounded, title: StringConstants.privacyPolicy),
];
