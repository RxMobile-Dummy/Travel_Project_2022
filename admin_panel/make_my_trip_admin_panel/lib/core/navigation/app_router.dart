import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/navigation/route_info.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/injection_container.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/cubit/hotel_cubit.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/pages/add_hotels.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/pages/get_hotels_ui.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/presentation/pages/home_page.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/admin_login_injection_container.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/presentation/cubit/admin_login_cubit.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/presentation/pages/admin_login_page.dart';
import 'package:make_my_trip_admin_panel/features/splash/presentation/cubit/splash_screen_cubit.dart';
import 'package:make_my_trip_admin_panel/features/splash/presentation/pages/splash_screen_page.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

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
              ..changeViewEvent(StringConstants.hotelLabel),
            child: (const HomePage()),
          );
        });
      case RoutesName.addHotel:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<HotelCubit>(
            create: (context) => hotelSl<HotelCubit>(),
            child: const AddHotels(),
          );
        });
      case RoutesName.getHotel:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<HotelCubit>(
            create: (context) => hotelSl<HotelCubit>()..getHotels(),
            child: GetHotelUi(),
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
