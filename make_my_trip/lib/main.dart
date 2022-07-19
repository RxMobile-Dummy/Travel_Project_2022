import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:make_my_trip/config/firebase/firebase_config.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_theme.dart';

import './core/navigation/app_router.dart' as AppRoutes;
import 'firebase_options.dart';
import './features/room_detail_page/room_detail_injection_container.dart' as di;




import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_theme.dart';
import './features/room_categories/room_categories_injection_container.dart'
    as di;

import './core/navigation/app_router.dart' as AppRoutes;
import 'firebase_options.dart';
import './features/room_categories/room_categories_injection_container.dart'
    as di;

import 'features/hotel_detail/hotel_detail_injection_container.dart' as diHotelDeatail;
import './features/home_page/home_page_injection_container.dart' as hp;



void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await diHotelDeatail.init();
  await hp.initializehomepage();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
