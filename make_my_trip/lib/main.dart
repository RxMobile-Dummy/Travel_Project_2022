import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_theme.dart';
import 'package:make_my_trip/features/home_page/presentation/pages/homepage.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/pages/hotel_list_page.dart';
import './features/hotel_listing/hotel_list_injection_container.dart' as di;
import './core/navigation/app_router.dart' as AppRoutes;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    );
  }
}
