import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';

///add more theme data here as per your need also add separate class for dark theme
class MakeMyTripLightTheme {
  MakeMyTripLightTheme._();

  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0,
      foregroundColor: Colors.black,
      centerTitle: true,
      color: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black,
      labelStyle: AppTextStyles.labelStyle,
      unselectedLabelStyle: AppTextStyles.unselectedLabelStyle,
    ),
  );
}
