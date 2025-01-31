import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';

class RouteHomePage {
  routeHomePage() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return const HomePage();
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(10.0, 1.0);
        const end = Offset.zero;
        Curve curve = Curves.decelerate;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
