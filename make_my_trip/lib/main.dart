import 'package:flutter/material.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_theme.dart';

import 'features/hotel_listing/presentation/pages/splash_page.dart';
import 'features/hotel_listing/hotel_listing_injection_container.dart' as di;
import './core/navigation/app_router.dart' as AppRoutes;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.initializeHotelListingFeature();
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
      //home: const SplashPage(),
    );
  }
}
