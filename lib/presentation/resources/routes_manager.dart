import 'package:chapt/presentation/home/home.dart';
import 'package:chapt/presentation/onboarding/onboarding_screen.dart';
import 'package:chapt/presentation/signin/signin.dart';
import 'package:chapt/presentation/signup/signup.dart';
import 'package:chapt/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String home = '/home';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.signin:
        return MaterialPageRoute(builder: (_) => const Signin());
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const Signup());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return undifinedRoute();
    }
  }

  static Route<dynamic> undifinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: const Center(
                child: Text('not Found'),
              ),
            ));
  }
}
