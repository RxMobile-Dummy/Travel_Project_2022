import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip_admin_panel/core/responsive/responsive.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/presentation/pages/review_moderation.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/admin_booking_moderation_injection_container.dart'
    as admin_booking_moderation_di;
import 'package:make_my_trip_admin_panel/features/admin_login/admin_login_injection_container.dart'
    as admin_login_di;
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';
import 'core/theme/make_my_trip_theme.dart';
import 'core/navigation/app_router.dart' as app_routes;
import 'firebase_options.dart';
import './features/review_moderation/review_moderation_injection_container.dart'
    as review_di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await review_di.init();
  await admin_login_di.init();
  await admin_booking_moderation_di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstants.appTitle,
      theme: MakeMyTripLightTheme.lightTheme,
      onGenerateRoute: app_routes.Router().generateRoutes,
    );
  }
}
