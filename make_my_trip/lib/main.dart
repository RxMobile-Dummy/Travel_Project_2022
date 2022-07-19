import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_theme.dart';
import './features/room_categories/room_categories_injection_container.dart'
    as di;

import './core/navigation/app_router.dart' as AppRoutes;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Make My Trip',
      theme: MakeMyTripLightTheme.lightTheme,
      onGenerateRoute: AppRoutes.Router.generateRoutes,
      initialRoute: RoutesName.roomCategory,
      //home: const SplashPage(),
    );
  }
}
