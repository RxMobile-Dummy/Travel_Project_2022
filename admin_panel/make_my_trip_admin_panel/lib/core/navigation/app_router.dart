import 'package:flutter/material.dart';

class Router {
  Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
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
