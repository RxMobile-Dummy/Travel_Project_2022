import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_theme.dart';
import 'features/hotel_listing/hotel_listing_injection_container.dart' as di;
import 'package:make_my_trip/features/home_page/presentation/pages/homepage.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/pages/hotel_list_page.dart';
import './features/hotel_listing/hotel_list_injection_container.dart' as di;
import './core/navigation/app_router.dart' as AppRoutes;
import 'injection_container.dart' as di;

void main() async {
<<<<<<< HEAD
  WidgetsFlutterBinding.ensureInitialized();
=======
  await WidgetsFlutterBinding.ensureInitialized();
>>>>>>> 8ce3b4e (feat(login_page) added authentication feature)
  await di.init();
  await Firebase.initializeApp();
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
