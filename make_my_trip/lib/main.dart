import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';

import 'package:make_my_trip/core/theme/make_my_trip_theme.dart';
import 'package:make_my_trip/features/user/user_injection_container.dart';
import 'package:make_my_trip/features/user/presentation/cubit/user_cubit.dart';

import './core/navigation/app_router.dart' as app_routes;
import 'firebase_options.dart';

import './features/home_page/home_page_injection_container.dart'
    as home_page_di;
import './features/hotel_detail/hotel_detail_injection_container.dart'
    as hotel_detail_di;
import './features/login/login_injection_container.dart' as login_di;
import './features/review/review_injection_container.dart' as review_di;
import './features/room_categories/room_categories_injection_container.dart'
    as room_category_di;
import './features/room_detail_page/room_detail_injection_container.dart'
    as room_detail_di;
import './features/sign_up/signup_injection_container.dart' as sign_up_di;

import './features/hotel_listing/hotel_list_injection_container.dart'
    as hotel_list_di;

import 'features/intro/intro_injection_container.dart' as intro_di;
import './features/wishlist/wishlist_injection_container.dart' as wishlist_di;
import 'features/user/user_injection_container.dart' as user_di;

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  await intro_di.init();
  await user_di.init();
  await home_page_di.init();
  await hotel_detail_di.init();
  await login_di.init();
  await review_di.init();
  await room_category_di.init();
  await room_detail_di.init();
  await sign_up_di.init();
  await hotel_list_di.init();
  await wishlist_di.init();

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => userSl<UserCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Make My Trip',
        theme: MakeMyTripLightTheme.lightTheme,
        onGenerateRoute: app_routes.Router.generateRoutes,
      ),
    );
  }
}
