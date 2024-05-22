import 'dart:async';

import 'package:chapt/app/app_prefs.dart';
import 'package:chapt/app/dependency_injection.dart';
import 'package:chapt/presentation/resources/assets_manager.dart';
import 'package:chapt/presentation/resources/routes_manager.dart';
import 'package:chapt/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startTimer() {
    _timer = Timer(const Duration(seconds: AppValues.i2), _moveToNext);
  }

  _moveToNext() {
    final bool isLoggedin = _appPreferences.isUserLoggedIn();
    if (isLoggedin) {
      Navigator.pushReplacementNamed(context, Routes.home);
    } else {
      // _appPreferences.isOnBoardingScreenViewed().then((isOnboardingViewed) {
      // if (isOnboardingViewed) {
      //   Navigator.pushReplacementNamed(context, Routes.signup);
      // } else {
      Navigator.pushReplacementNamed(context, Routes.onboarding);
      // }
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(AssetsManager.splash),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
