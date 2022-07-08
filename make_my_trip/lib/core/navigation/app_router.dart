import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/pages/splash_page.dart';
import 'package:make_my_trip/features/intro/presentation/cubit/intro_cubit.dart';
import 'package:make_my_trip/features/intro/presentation/pages/intro_page.dart';

///your app router here ::: use your route cubit

class Router {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (_) {
          return SplashPage();
        });
      case RoutesName.introScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => IntroCubit(),
            child: IntroPage(),
          );
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
