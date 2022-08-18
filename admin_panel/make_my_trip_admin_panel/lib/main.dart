import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip_admin_panel/core/navigation/route_info.dart';
import 'core/theme/make_my_trip_theme.dart';
import 'core/navigation/app_router.dart' as app_routes;
import 'firebase_options.dart';
import '../../features/about_us/about_us_injection_container.dart' as di;
import 'package:make_my_trip_admin_panel/features/faq/presentation/pages/faq_page.dart';
import 'features/faq/presentation/pages/faq_page.dart';
import '../../features/privacy_policy/privacy_policy_injection_container.dart'
    as dipp;
import '../../features/terms_condition/terms_condition_injection_container.dart'
    as ditc;

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  await dipp.init();
  await ditc.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "StringConstants.appTitle",
      theme: MakeMyTripLightTheme.lightTheme,
      onGenerateRoute: app_routes.Router().generateRoutes,
      initialRoute: RoutesName.tc,
    );
  }
}
