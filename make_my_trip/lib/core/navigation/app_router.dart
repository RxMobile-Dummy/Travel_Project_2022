import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/features/home_page/presentation/pages/homepage.dart';

import 'package:make_my_trip/features/hotel_listing/presentation/pages/splash_page.dart';
import 'package:make_my_trip/features/login/presentation/cubit/login_cubit.dart';
import 'package:make_my_trip/features/login/presentation/pages/login_page.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/pages/hotel_list_page.dart';

import '../../injection_container.dart';

///your app router here ::: use your route manager

class Router {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.hotelListPage:
        return MaterialPageRoute(builder: (_) {
          return HotelListPage();
        });
      case RoutesName.login:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => sl<LoginCubit>(),
            child: LoginPage(),
          );
        });
      case RoutesName.home:
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
