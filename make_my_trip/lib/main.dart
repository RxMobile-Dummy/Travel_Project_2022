import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_theme.dart';

import './core/navigation/app_router.dart' as AppRoutes;
import './features/hotel_detail//injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await di.init();
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
      initialRoute: RoutesName.hotelDetail,
    );
  }
}
