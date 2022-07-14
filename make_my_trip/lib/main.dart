
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_theme.dart';

import './core/navigation/app_router.dart' as AppRoutes;
import './features/room_detail_page/room_detail_injection_container.dart' as di;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      initialRoute: RoutesName.roomDetail,//home: const SplashPage(),
    );
  }
}
