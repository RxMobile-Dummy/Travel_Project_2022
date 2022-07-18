import 'package:flutter/material.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/pages/hotel_list_page.dart';

///your app router here ::: use your route manager

class Router {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.hotelListPage:
        return MaterialPageRoute(builder: (_) {
          return HotelListPage();
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