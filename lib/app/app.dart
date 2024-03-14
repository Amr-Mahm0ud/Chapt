import 'package:chapt/presentation/resources/routes_manager.dart';
import 'package:chapt/presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();
  static const MyApp _app = MyApp._internal(); //singleton
  factory MyApp() => _app;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splash,
      theme: getAppTheme(),
    );
  }
}
