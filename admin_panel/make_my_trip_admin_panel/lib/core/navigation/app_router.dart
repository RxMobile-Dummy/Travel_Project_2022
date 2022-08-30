import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/injection_container.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/cubit/hotel_cubit.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/pages/add_hotels.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/pages/get_hotels_ui.dart';

import 'route_info.dart';

class Router {
  Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.adminHotelAdd:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<HotelCubit>(
            create: (context) =>
            sl<HotelCubit>(),
            child: (AddHotels()),
          );
        });
      case RoutesName.adminHotelGet:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<HotelCubit>(
            create: (context) =>
            sl<HotelCubit>(),
            child: (GetHotelUi()),
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
