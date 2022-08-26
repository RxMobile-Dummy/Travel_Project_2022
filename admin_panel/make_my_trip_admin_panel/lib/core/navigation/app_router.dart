import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/navigation/route_info.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/presentation/pages/home_page.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/admin_login_injection_container.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/presentation/cubit/admin_login_cubit.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/presentation/pages/admin_login_page.dart';
import 'package:make_my_trip_admin_panel/features/splash/presentation/cubit/splash_screen_cubit.dart';
import 'package:make_my_trip_admin_panel/features/splash/presentation/pages/splash_screen_page.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/presentation/cubit/push_notification_cubit.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/presentation/pages/push_notification_admin.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/push_notification_injection_container.dart';

class Router {
  Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<SplashCubit>(
            create: (context) => SplashCubit()..splashLoad(),
            child: const SplashPage(),
          );
        });
      case RoutesName.adminLogin:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AdminLoginCubit>(
            create: (context) => slAdminLogin<AdminLoginCubit>(),
            child: AdminLoginPage(),
          );
        });
      case RoutesName.homePage:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AdminLoginCubit>(
            create: (context) => slAdminLogin<AdminLoginCubit>()
              ..changeViewEvent(StringConstants.bookingModerationLabel),
            child: (const HomePage()),
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
