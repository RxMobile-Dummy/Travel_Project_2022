import 'package:flutter/material.dart';

class AppAnimation {
  Route createRouteSlide(page) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(-1, -.5), end: Offset.zero)
                .animate(
                    CurvedAnimation(parent: animation, curve: Curves.bounceIn)),
            child: child,
          );
        });
  }

//for scale transition it not need the position so using double instead of offset
  Route createRouteScale(page) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                parent: animation, curve: Curves.fastOutSlowIn)),
            child: child,
          );
        });
  }

  Route createRouteMultiple(page) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                parent: animation, curve: Curves.fastOutSlowIn)),
            child: RotationTransition(
                turns: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                    parent: animation, curve: Curves.fastOutSlowIn)),
                child: child),
          );
        });
  }

  Route createRouteFade(page) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        });
  }
}
