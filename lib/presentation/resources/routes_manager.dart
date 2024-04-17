import 'package:chapt/presentation/screens/home/home.dart';
import '../../app/dependency_injection.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../resources/app_strings.dart';
import '../screens/signin/signin.dart';
import '../screens/signup/signup.dart';
import '../screens/splash/splash_screen.dart';
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
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const Signin());
      case Routes.signup:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const Signup());
      case Routes.home:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return undifinedRoute();
    }
  }

  static Route<dynamic> undifinedRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Center(
                child: Text(AppStrings.noRoute),
              ),
            ));
  }
}
