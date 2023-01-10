import 'package:flutter/material.dart';

import '../../view/home_view.dart';
import '../../view/login_view.dart';
import '../../view/sign_up_view.dart';
import '../../view/splash_view.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeView(),
        );
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashView(),
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginView(),
        );
      case RoutesName.signUp:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SignUpView(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text("No Route Defined!"),
              ),
            );
          },
        );
    }
  }
}
