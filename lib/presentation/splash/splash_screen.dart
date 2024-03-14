import 'dart:async';

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

  _startTimer() {
    _timer = Timer(const Duration(seconds: AppValues.i2), _moveToNext);
  }

  _moveToNext() {
    Navigator.pushReplacementNamed(context, Routes.onboarding);
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
