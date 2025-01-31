import 'package:flutter/material.dart';
import 'package:flutter_app/features/auth/routes/auth_routes.dart';
import 'package:flutter_app/features/frequencia/views/page_frequencia.dart';
import 'package:flutter_app/features/profile/routes/profile_routes.dart';
import 'package:flutter_app/features/profile/views/profile_view.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/routes/animation_route.dart';
import 'package:flutter_app/widgets/bottom_nvigation_bar.dart';

class Routes {
  static Map<String, Widget Function(BuildContext, RouteSettings)>
      _resolveRoutes() {
    return {
      'home': (context, settings) => const HomePage(),
      'profile': (context, settings) => const ProfileView(),
      'bottomBar': (context, settings) => const BottomNavigationBar2(),
      'frequencia': ((context, p1) => const PageFrequencia()),
      //"pdisciplina": (context, settings) => PageDisciplina(),
      ...authRoutes,
      ...profileRoutes
    };
  }

  generateRoutes(RouteSettings settings) {
    Map routes = _resolveRoutes();
    try {
      final child = routes[settings.name];
      if (routes.containsKey(settings.name)) {
        // debugPrint(routes.toString());
        Widget builder(BuildContext context) => child(context, settings);
        if (settings.name == "reauthenticate" ||
            settings.name == "forgot" ||
            settings.name == 'profileDisplayName') {
          return AnimationRoute().animationTransitionRoute(builder: builder);
        }
        return MaterialPageRoute(builder: builder);
      } else {
        debugPrint("nome de rota está errado");
      }
    } catch (e) {
      throw const FormatException("Route doesn't exist");
    }
  }
}
