import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/admin_booking_moderation_injection_container.dart'
    as admin_booking_moderation_di;
import 'package:make_my_trip_admin_panel/features/admin_login/admin_login_injection_container.dart'
    as admin_login_di;
import 'package:make_my_trip_admin_panel/firebase_options.dart';
import 'core/navigation/app_router.dart' as app_routes;
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';
import 'core/theme/make_my_trip_theme.dart';
import './features/review_moderation/review_moderation_injection_container.dart'
    as review_di;
import '../../features/about_us/about_us_injection_container.dart' as di;
import '../../features/privacy_policy/privacy_policy_injection_container.dart'
    as dipp;
import '../../features/terms_condition/terms_condition_injection_container.dart'
    as ditc;
import '../../features/faq/faq_injection_container.dart' as difaq;
import 'package:make_my_trip_admin_panel/features/push_notification/push_notification_injection_container.dart'
    as push_notification_di;
import './features/add_hotels/injection_container.dart' as di_hotel;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await review_di.init();
  await admin_login_di.init();
  await admin_booking_moderation_di.init();
  await di.init();
  await dipp.init();
  await ditc.init();
  await difaq.init();
  await push_notification_di.init();
  await di_hotel.init();
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
