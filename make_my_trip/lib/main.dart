import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';

import 'package:make_my_trip/core/theme/make_my_trip_theme.dart';

import './core/navigation/app_router.dart' as appRoutes;
import 'firebase_options.dart';

import './features/home_page/home_page_injection_container.dart' as homePageDi;
import './features/hotel_detail/hotel_detail_injection_container.dart'
    as hotelDetailDi;
import './features/login/login_injection_container.dart' as loginDi;
import './features/review/review_injection_container.dart' as reviewDi;
import './features/room_categories/room_categories_injection_container.dart'
    as roomCategoryDi;
import './features/room_detail_page/room_detail_injection_container.dart'
    as roomDetailDi;
import './features/sign_up/signup_injection_container.dart' as signUpDi;

import './features/hotel_listing/hotel_list_injection_container.dart'
    as hotelListDi;

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  await homePageDi.init();
  await hotelDetailDi.init();
  await loginDi.init();
  await reviewDi.init();
  await roomCategoryDi.init();
  await roomDetailDi.init();
  await signUpDi.init();
  await hotelListDi.init();

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
      title: 'Make My Trip',
      theme: MakeMyTripLightTheme.lightTheme,
      onGenerateRoute: appRoutes.Router.generateRoutes,
    );
  }
}
