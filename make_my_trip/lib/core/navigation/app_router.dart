import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';

import '../../features/home_page/presentation/manager/cubit/tab_bar_cubit.dart';
import '../../features/home_page/presentation/pages/homepage.dart';

import '../../features/hotel_detail/hotel_detail_injection_container.dart';
import '../../features/hotel_detail/presentation/cubit/hotel_detail_cubit.dart';
import '../../features/hotel_detail/presentation/pages/hotel_detail_page.dart';
import '../../features/intro/presentation/cubit/intro_cubit.dart';
import '../../features/intro/presentation/pages/intro_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

import '../../features/login/presentation/cubit/login_cubit.dart';
import '../../features/login/presentation/pages/login_page.dart';
import '../../injection_container.dart';

///your app router here ::: use your route manager

class Router {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (_) {
          return const SplashPage();
        });
      case RoutesName.onBoard:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => IntroCubit(),
            child: IntroPage(),
          );
        });
      case RoutesName.login:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => sl<LoginCubit>(),
            child: LoginPage(),
          );
        });
      case RoutesName.signup:
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
      case RoutesName.otp:
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
      case RoutesName.verifyEmail:
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
      case RoutesName.resetPassword:
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
      case RoutesName.home:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => TabBarCubit(),
            child: HomePage(),
          );
        });
      case RoutesName.myTrips:
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
      case RoutesName.wishList:
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
      case RoutesName.profile:
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
      case RoutesName.search:
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
      case RoutesName.hotelList:
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
      case RoutesName.hotelDetail:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => sl<HotelDetailCubit>(),
            child: HotelDetailPage(),
          );
        });
      case RoutesName.roomCategory:
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
      case RoutesName.roomDetail:
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
